report 50001 CreateCompaniesReport
{
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(CompanyMapping; "CompanyMappingTable")
        {
            trigger OnPreDataItem()
            begin
                Progress.Open('Processing record #1###### -- #2###### out of #3######');
                Progress.Update(3, Count());
            end;

            trigger OnAfterGetRecord()
            begin
                if rLExistingCompany.Get(CompanyMapping."ShippingCompany Code") then begin
                    rLExistingCompany.Name := CompanyMapping.Name;
                    rLExistingCompany."Company Type" := CompanyMapping."Company Type";
                    rLExistingCompany."Vessel Name" := CompanyMapping."Vessel Name";
                    rLExistingCompany."Short Name" := CompanyMapping."Short Name";
                    rLExistingCompany."Old Code" := CompanyMapping."Old Code";

                    rLExistingCompany.Modify(true);
                end
                else begin
                    rLNewCompany.Init();
                    rLNewCompany."Code" := CompanyMapping."ShippingCompany Code";
                    rLNewCompany."Name" := CompanyMapping.Name;
                    rLNewCompany."Company Type" := CompanyMapping."Company Type";
                    rLNewCompany."Vessel Name" := CompanyMapping."Vessel Name";
                    rLNewCompany."Short Name" := CompanyMapping."Short Name";
                    rLNewCompany."Old Code" := CompanyMapping."Old Code";
                    rLNewCompany.Insert(true);
                end;


                nCount += 1;
                Progress.Update(1, "Old Code");
                Progress.Update(2, nCount);
            end;




            trigger OnPostDataItem()
            begin
                Progress.Close();
                MESSAGE('Number of records processed: %1', nCount);
            end;

        }

    }


    var
        Progress: Dialog;
        nCount: Integer;
        rLExistingCompany: record "Company FTN";
        rLNewCompany: record "Company FTN";


}
