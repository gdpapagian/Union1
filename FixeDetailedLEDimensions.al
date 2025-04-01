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
        dataitem(DVLETable; "DVLETable")
        {
            trigger OnAfterGetRecord()
            var
                shippingCompany: Code[20];
                detailedVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
            begin
                detailedVendLedgEntry.GET("Entry No.");
                shippingCompany := cuUtil.GetCompanyFromDimValues(DVLETable.EntityValue, DVLETable.BusUnitValue);
                if detailedVendLedgEntry."Initial Entry Global Dim. 1" <> shippingCompany then begin
                    detailedVendLedgEntry."Initial Entry Global Dim. 1" := shippingCompany;
                    detailedVendLedgEntry.Modify();
                    nDVLEModified += 1;
                end;

                nDVLEProcessed += 1;
                progress.Update(1, nDVLEProcessed);
                progress.Update(2, nDVLEModified);
            end;

        }

        dataitem(DCLETable; "DCLETable")
        {
            trigger OnAfterGetRecord()
            var
                shippingCompany: Code[20];
                detailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
            begin
                detailedCustLedgEntry.GET("Entry No.");
                shippingCompany := cuUtil.GetCompanyFromDimValues(DCLETable.EntityValue, DCLETable.BusUnitValue);
                if detailedCustLedgEntry."Initial Entry Global Dim. 1" <> shippingCompany then begin
                    detailedCustLedgEntry."Initial Entry Global Dim. 1" := shippingCompany;
                    detailedCustLedgEntry.Modify();
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
