codeunit 50000 DimUtilCU_GP
{
    Permissions =
        TableData "Dimension Set Entry" = rim;

    // Fixes the DimensionSet by adding a SHIPPINGCOMPANY code, and also returns this code
    // If there is a BUSUNIT then SHIPPINGCOMPANY := mapping of BUSUNIT
    // otherwise SHIPPINGCOMPANY := mapping of ENTITY;

    procedure FixDimensionSet(dimensionSetID: Integer;
        var bInserted: Boolean;
        var bModified: Boolean): Code[20]
    var
        dimSetENTITY: Record "Dimension Set Entry";
        dimSetBUSUNIT: Record "Dimension Set Entry";
        dimSetSHIPPINGCOMPANY: Record "Dimension Set Entry";
        dimSetEntryNew: Record "Dimension Set Entry";
        dimSHIPPINGCOMPANY: Record "Dimension Value";
        bInsertDimSetEntry: Boolean;
        bModifyDimSetEntry: Boolean;
        companyMapping: Record "CompanyMappingTable";
        bFoundEligibleBU: Boolean;

        shippingCompany: Code[20];
    begin
        if dimSetENTITY.Get(dimensionSetID, 'ENTITY') then begin
            if dimSetENTITY."Dimension Value Code" <> 'UMLUG01' then begin
                companyMapping.Get(companyMapping."Line Type"::ENTITY, dimSetENTITY."Dimension Value Code");
                shippingCompany := companyMapping."ShippingCompany Code";
            end
            else begin
                //UNION GLORY case
                if dimSetBUSUNIT.Get(dimensionSetID, 'BUSUNIT') then
                    bFoundEligibleBU := companyMapping.Get(companyMapping."Line Type"::BUSUNIT, dimSetBUSUNIT."Dimension Value Code");
                if bFoundEligibleBU then
                    shippingCompany := companyMapping."ShippingCompany Code"
                else
                    shippingCompany := 'UMLUG01';
            end;
        end
        else begin
            companyMapping.Get(companyMapping."Line Type"::OTHER, '');
            shippingCompany := companyMapping."ShippingCompany Code"; //Unknown company
        end;
        dimSHIPPINGCOMPANY.Get('SHIPPINGCOMPANY', shippingCompany);
        if dimensionSetID <> 0 then begin
            if dimSetSHIPPINGCOMPANY.Get(dimensionSetID, 'SHIPPINGCOMPANY') then
                bModifyDimSetEntry := dimSetSHIPPINGCOMPANY."Dimension Value Code" <> shippingCompany
            else
                bInsertDimSetEntry := true;

            if bModifyDimSetEntry then begin
                dimSetSHIPPINGCOMPANY."Dimension Value Code" := shippingCompany;
                dimSetSHIPPINGCOMPANY.Modify(true);
            end;

            if bInsertDimSetEntry then begin
                dimSetENtryNew.Init();
                dimSetENtryNew."Dimension Set ID" := dimensionSetID;
                dimSetENtryNew.Validate("Dimension Code", 'SHIPPINGCOMPANY');
                dimSetENtryNew.Validate("Dimension Value Code", shippingCompany);
                dimSetENtryNew.Insert(true);
            end;
        end;

        bInserted := bInsertDimSetEntry;
        bModified := bModifyDimSetEntry;
        exit(shippingCompany);
    end;

    procedure FixDefaultDimensions(tableID: Integer;
            recordNo: Code[20];
            var bInserted: Boolean;
            var bModified: Boolean): Code[20]
    var
        defDimENTITY: Record "Default Dimension";
        defDimnBusinessUnit: Record "Default Dimension";
        defDimSHIPPINGCOMPANY: Record "Default Dimension";
        defaultDimNew: Record "Default Dimension";
        dimSHIPPINGCOMPANY: Record "Dimension Value";
        bInsertDefDimEntry: Boolean;
        bModifyDefDimEntry: Boolean;
        companyMapping: Record "CompanyMappingTable";
        bFoundEligibleBU: Boolean;

        shippingCompany: Code[20];
    begin



        if defDimENTITY.Get(tableID, recordNo, 'ENTITY') then begin
            if defDimENTITY."Dimension Value Code" <> 'UMLUG01' then begin
                companyMapping.Get(companyMapping."Line Type"::ENTITY, defDimENTITY."Dimension Value Code");
                shippingCompany := companyMapping."ShippingCompany Code";
            end

            else begin
                //UNION GLORY case
                if defDimnBusinessUnit.Get(tableID, recordNo, 'BUSUNIT') then
                    bFoundEligibleBU := companyMapping.Get(companyMapping."Line Type"::BUSUNIT, defDimnBusinessUnit."Dimension Value Code");
                if bFoundEligibleBU then
                    shippingCompany := companyMapping."ShippingCompany Code"
                else
                    shippingCompany := 'UMLUG01';
            end;
        end
        else begin
            companyMapping.Get(companyMapping."Line Type"::OTHER, '');
            shippingCompany := companyMapping."ShippingCompany Code"; //Unknown company
        end;

        dimSHIPPINGCOMPANY.Get('SHIPPINGCOMPANY', shippingCompany);

        if defDimSHIPPINGCOMPANY.Get(tableID, recordNo, 'SHIPPINGCOMPANY') then
            bModifyDefDimEntry := defDimSHIPPINGCOMPANY."Dimension Value Code" <> shippingCompany
        else
            bInsertDefDimEntry := true;

        if bModifyDefDimEntry then begin
            defDimSHIPPINGCOMPANY."Dimension Value Code" := shippingCompany;
            defDimSHIPPINGCOMPANY.Modify(true);
        end;

        if bInsertDefDimEntry then begin
            defaultDimNew.Init();
            defaultDimNew."Table ID" := tableID;
            defaultDimNew."No." := recordNo;
            defaultDimNew.Validate("Dimension Code", 'SHIPPINGCOMPANY');
            defaultDimNew.Validate("Dimension Value Code", shippingCompany);
            defaultDimNew.Insert(true);
        end;

        bInserted := bInsertDefDimEntry;
        bModified := bModifyDefDimEntry;
        exit(shippingCompany);
    end;

    procedure getCompanyFromDefDim(tableID: Integer;
        recordNo: Code[20]): Code[20]
    var
        defDimENTITY: Record "Default Dimension";
        defDimnBusinessUnit: Record "Default Dimension";
        defDimSHIPPINGCOMPANY: Record "Default Dimension";
        defaultDimNew: Record "Default Dimension";
        dimSHIPPINGCOMPANY: Record "Dimension Value";
        bInsertDefDimEntry: Boolean;
        bModifyDefDimEntry: Boolean;
        companyMapping: Record "CompanyMappingTable";
        bFoundEligibleBU: Boolean;

        shippingCompany: Code[20];
    begin
        if defDimnBusinessUnit.Get(tableID, recordNo, 'BUSUNIT') then
            bFoundEligibleBU := companyMapping.Get(companyMapping."Line Type"::BUSUNIT, defDimnBusinessUnit."Dimension Value Code");
        if bFoundEligibleBU then
            shippingCompany := companyMapping."ShippingCompany Code"
        else if defDimENTITY.Get(tableID, recordNo, 'ENTITY') then begin
            if not companyMapping.Get(companyMapping."Line Type"::ENTITY, defDimENTITY."Dimension Value Code") then begin
                message('Entity not found in CompanyMappingTable for %1 (Table ID %2, RecordNo %3)',
                defDimENTITY."Dimension Value Code",
                tableID,
                recordNo);
                shippingCompany := '0';
            end
            else
                shippingCompany := companyMapping."ShippingCompany Code";
        end
        else begin
            companyMapping.Get(companyMapping."Line Type"::OTHER, '');
            shippingCompany := companyMapping."ShippingCompany Code"; //Unknown company
        end;
        //dimSHIPPINGCOMPANY.Get('SHIPPINGCOMPANY', shippingCompany);

        exit(shippingCompany);
    end;


}