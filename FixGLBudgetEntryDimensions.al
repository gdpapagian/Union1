report 50004 "Fix G/L Budget Entry Dim"
{
    ProcessingOnly = true;

    Permissions =
        TableData "G/L Budget Entry" = rm,
        TableData "Dimension Set Entry" = rim;


    UsageCategory = None;

    ApplicationArea = All;
    Caption = 'Fix G/L Budget Entry Dimensions';

    dataset
    {
        dataitem("G/L Budget Entry"; "G/L Budget Entry")
        {
            trigger onPreDataItem()
            begin
                progress.Open(
                'G/L Budget Entries: #1###### \ ' +
                'G/L Budget Entries Processed: #2######  \ ' +
                'Dimension Sets Modified: #3######  \ ' +
                'Dimension Sets Inserted: #4######  ');
                progress.Update(2, 0);
                progress.Update(1, Count());

            end;


            trigger OnAfterGetRecord()
            var
                shippingCompany: Code[20];
            begin
                shippingCompany := FixDimensionSetForBudget("Dimension Set ID", bDimSetInserted, bDimSetModified);
                if "Global Dimension 1 Code" <> shippingCompany then begin
                    "Global Dimension 1 Code" := shippingCompany;
                    Modify();
                end;
                if bDimSetInserted then nDimSetInserted += 1;
                if bDimSetModified then nDimSetModified += 1;
                nGLBudEntryProcessed += 1;
                progress.Update(2, nGLBudEntryProcessed);
                progress.Update(3, nDimSetModified);
                progress.Update(4, nDimSetInserted);
            end;



            trigger OnPostDataItem()
            begin
                progress.Close();
                MESSAGE(
                'G/L Budget Entries Processed: %1 \ ' +
                'Dimension Sets Modified: %2 \ ' +
                'Dimension Sets Inserted: %3 \ ',
                nGLBudEntryProcessed, nDimSetModified, nDimSetInserted);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Group)
                {

                }
            }
        }


    }


    trigger OnPreReport()
    begin
    end;

    trigger OnPostReport()
    begin
    end;


    var
        nGLBudEntryProcessed: Integer;
        nDimSetModified: Integer;
        nDimSetInserted: Integer;
        bDimSetModified: Boolean;
        bDimSetInserted: Boolean;

        progress: Dialog;

        cuUtil: Codeunit DimUtilCU_GP;

    procedure FixDimensionSetForBudget(dimensionSetID: Integer;
        var bInserted: Boolean;
        var bModified: Boolean): Code[20]
    var
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
        if dimSetBUSUNIT.Get(dimensionSetID, 'BUSUNIT') then begin
            if companyMapping.Get(companyMapping."Line Type"::BUSUNIT, dimSetBUSUNIT."Dimension Value Code") then
                shippingCompany := companyMapping."ShippingCompany Code"
            //search BU as ENTITY. This is a peculiarity of OPEX dimensions in G/L Budget Entries
            else if companyMapping.Get(companyMapping."Line Type"::ENTITY, dimSetBUSUNIT."Dimension Value Code") then
                shippingCompany := companyMapping."ShippingCompany Code"
            else begin
                companyMapping.Get(companyMapping."Line Type"::OTHER, '');
                shippingCompany := companyMapping."ShippingCompany Code"; //Unknown company
            end;
            dimSHIPPINGCOMPANY.Get('SHIPPINGCOMPANY', shippingCompany);

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
}