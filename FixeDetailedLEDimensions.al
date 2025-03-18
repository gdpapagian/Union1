report 50006 "Fix Detailed LE Dimensions"
{
    ProcessingOnly = true;

    Permissions =
        TableData "Detailed Vendor Ledg. Entry" = rm,
        TableData "Detailed Cust. Ledg. Entry" = rm;

    UsageCategory = None;

    ApplicationArea = All;
    Caption = 'Fix Detailed LE Dimensions';

    dataset
    {
        dataitem("Detailed Vendor Ledg. Entry"; "Detailed Vendor Ledg. Entry")
        {
            trigger OnAfterGetRecord()
            var
                shippingCompany: Code[20];
                detailedLE: Record DVLETable;
            begin
                if detailedLE.GET("Entry No.") then
                    shippingCompany := cuUtil.GetCompanyFromDimValues(detailedLE.EntityValue, detailedLE.BusUnitValue);
                if "Initial Entry Global Dim. 1" <> shippingCompany then begin
                    "Initial Entry Global Dim. 1" := shippingCompany;
                    Modify();
                    nDVLEModified += 1;
                end;

                nDVLEProcessed += 1;
                progress.Update(1, nDVLEProcessed);
                progress.Update(2, nDVLEModified);
            end;

        }

        dataitem("Detailed Cust. Ledg. Entry"; "Detailed Cust. Ledg. Entry")
        {
            trigger OnAfterGetRecord()
            var
                shippingCompany: Code[20];
                detailedLE: Record DCLETable;
            begin
                detailedLE.GET("Entry No.");
                shippingCompany := cuUtil.GetCompanyFromDimValues(detailedLE.EntityValue, detailedLE.BusUnitValue);
                if "Initial Entry Global Dim. 1" <> shippingCompany then begin
                    "Initial Entry Global Dim. 1" := shippingCompany;
                    Modify();
                    nDCLEModified += 1;
                end;

                nDCLEProcessed += 1;
                progress.Update(1, nDVLEProcessed);
                progress.Update(2, nDVLEModified);
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
        progress.Open(
        'Detailed Vendor Ledger Entries Processed: #1###### \ ' +
        'Detailed Vendor Ledger Entries:Modified: #2###### \ ' +
        'Detailed Cust. Ledger Entries:Processed: #3###### \ ' +
        'Detailed Cust. Ledger Entries Modified: #4###### ');
    end;


    trigger OnPostReport()
    begin
        progress.Close();
        MESSAGE(
        'Detailed Vendor Ledger Entries: Processed: %1 Modified: %2 \ ' +
        'Detailed Cust. Ledger Entries: Processed: %3 Modified: %4 ',
        nDVLEProcessed, nDVLEModified,
        nDCLEProcessed, nDCLEModified);
    end;


    var
        nDVLEProcessed: Integer;
        nDVLEModified: Integer;
        nDCLEProcessed: Integer;
        nDCLEModified: Integer;
        nCLEProcessed: Integer;

        progress: Dialog;

        cuUtil: Codeunit DimUtilCU_GP;
}
