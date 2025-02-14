report 50003 "Fix VAT Entry Dimensions"
{
    ProcessingOnly = true;

    Permissions =
        TableData "VAT Entry" = rm;


    UsageCategory = None;

    ApplicationArea = All;
    Caption = 'Fix VAT Entry Dimensions';

    dataset
    {
        dataitem("VAT Entry"; "VAT Entry")
        {
            trigger onPreDataItem()
            begin
                progress.Open(
                'VAT Entries: #1###### \ ' +
                'VAT Entries Processed: #2###### ');
                progress.Update(2, 0);
                progress.Update(1, Count());

            end;

            trigger OnAfterGetRecord()
            var
                shippingCompany: Code[20];
                rL_GLEntry: Record "G/L Entry";
                firstTime: Boolean;
                isIntercompanyDoc: Boolean;
            begin
                rL_GLEntry.SetCurrentKey("Document No.");
                rL_GLEntry.SetRange("Document No.", "Document No.");
                rL_GLEntry.SetRange("Document Type", "Document Type");
                firstTime := true;
                isIntercompanyDoc := false;
                if rL_GLEntry.FindSet() then begin
                    if firstTime then begin
                        shippingCompany := rL_GLEntry."Global Dimension 1 Code";
                        firstTime := false;
                    end;
                    if rL_GLEntry."Global Dimension 1 Code" <> shippingCompany then begin
                        isIntercompanyDoc := true;
                    end;
                end;

                if not isIntercompanyDoc then begin
                    Validate("Global Dimension 1 Code FTN", shippingCompany);
                    Modify();
                end;

                nVATProcessed += 1;
                progress.Update(2, nVATProcessed);
            end;

            trigger OnPostDataItem()
            begin
                progress.Close();
                MESSAGE(
                'VAT Entries Processed: %1 ', nVATProcessed);
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

        actions
        {
            area(processing)
            {
                action("Run Report")
                {
                    trigger OnAction()
                    begin
                        // Add code to run the report
                    end;
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
        nVATProcessed: Integer;


        progress: Dialog;

        cuUtil: Codeunit DimUtilCU_GP;
}