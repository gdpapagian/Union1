report 50000 "Fix Entry Dimensions"
{
    ProcessingOnly = true;

    Permissions =
        TableData "G/L Entry" = rm,
        TableData "Vendor Ledger Entry" = rm,
        TableData "Cust. Ledger Entry" = rm,
        TableData "Bank Account Ledger Entry" = rm,
        TableData "FA Ledger Entry" = rm,
        TableData "Dimension Set Entry" = rim;

    UsageCategory = None;

    ApplicationArea = All;
    Caption = 'Fix G/L Dimensions';

    dataset
    {
        dataitem("G/L Register"; "G/L Register")
        {

            dataitem("G/L Entry"; "G/L Entry")
            {
                trigger OnPreDataItem()
                begin
                    SetRange("Entry No.", "G/L Register"."From Entry No.", "G/L Register"."To Entry No.");
                end;

                trigger OnAfterGetRecord()
                var
                    shippingCompany: Code[20];
                begin
                    shippingCompany := cuUtil.FixDimensionSet("Dimension Set ID", bDimSetInserted, bDimSetModified);
                    if "Global Dimension 1 Code" <> shippingCompany then begin
                        "Global Dimension 1 Code" := shippingCompany;
                        Modify();
                        nGLModified += 1;
                    end;
                    if bDimSetInserted then nDimSetInserted += 1;
                    if bDimSetModified then nDimSetModified += 1;
                    nGLProcessed += 1;
                    "Extended Description FTN" := Description;
                    progress.Update(4, nGLProcessed);
                    progress.Update(5, nGLModified);
                    progress.Update(14, nDimSetModified);
                    progress.Update(15, nDimSetInserted);
                end;

                trigger OnPostDataItem()
                begin
                end;
            }

            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                trigger OnPreDataItem()
                begin
                    SetRange("Entry No.", "G/L Register"."From Entry No.", "G/L Register"."To Entry No.");
                end;

                trigger OnAfterGetRecord()
                var
                    shippingCompany: Code[20];
                begin
                    shippingCompany := cuUtil.FixDimensionSet("Dimension Set ID", bDimSetInserted, bDimSetModified);
                    if "Global Dimension 1 Code" <> shippingCompany then begin
                        "Global Dimension 1 Code" := shippingCompany;
                        Modify();
                        nVLEModified += 1;
                    end;
                    if bDimSetInserted then nDimSetInserted += 1;
                    if bDimSetModified then nDimSetModified += 1;
                    nVLEProcessed += 1;
                    progress.Update(6, nVLEProcessed);
                    progress.Update(7, nVLEModified);
                    progress.Update(14, nDimSetModified);
                    progress.Update(15, nDimSetInserted);
                end;

                trigger OnPostDataItem()
                begin
                end;
            }

            dataitem("Customer Ledger Entry"; "Cust. Ledger Entry")
            {
                trigger OnPreDataItem()
                begin
                    SetRange("Entry No.", "G/L Register"."From Entry No.", "G/L Register"."To Entry No.");
                end;

                trigger OnAfterGetRecord()
                var
                    shippingCompany: Code[20];
                begin
                    shippingCompany := cuUtil.FixDimensionSet("Dimension Set ID", bDimSetInserted, bDimSetModified);
                    if "Global Dimension 1 Code" <> shippingCompany then begin
                        "Global Dimension 1 Code" := shippingCompany;
                        Modify();
                        nCLEModified += 1;
                    end;
                    if bDimSetInserted then nDimSetInserted += 1;
                    if bDimSetModified then nDimSetModified += 1;
                    nCLEProcessed += 1;
                    progress.Update(8, nCLEProcessed);
                    progress.Update(9, nCLEModified);
                    progress.Update(14, nDimSetModified);
                    progress.Update(15, nDimSetInserted);
                end;

                trigger OnPostDataItem()
                begin
                end;
            }

            dataitem("Bank Ledger Entry"; "Bank Account Ledger Entry")
            {
                trigger OnPreDataItem()
                begin
                    SetRange("Entry No.", "G/L Register"."From Entry No.", "G/L Register"."To Entry No.");
                end;

                trigger OnAfterGetRecord()
                var
                    shippingCompany: Code[20];
                begin
                    shippingCompany := cuUtil.FixDimensionSet("Dimension Set ID", bDimSetInserted, bDimSetModified);
                    if "Global Dimension 1 Code" <> shippingCompany then begin
                        "Global Dimension 1 Code" := shippingCompany;
                        Modify();
                        nBLEModified += 1;
                    end;
                    if bDimSetInserted then nDimSetInserted += 1;
                    if bDimSetModified then nDimSetModified += 1;
                    nBLEProcessed += 1;
                    progress.Update(10, nBLEProcessed);
                    progress.Update(11, nBLEModified);
                    progress.Update(14, nDimSetModified);
                    progress.Update(15, nDimSetInserted);
                end;

                trigger OnPostDataItem()
                begin
                end;
            }
            dataitem("FA Ledger Entry"; "FA Ledger Entry")
            {
                trigger OnPreDataItem()
                begin
                    SetRange("Entry No.", "G/L Register"."From Entry No.", "G/L Register"."To Entry No.");
                    SetFilter("Dimension Set ID", '<>0');
                end;

                trigger OnAfterGetRecord()
                var
                    shippingCompany: Code[20];
                begin
                    shippingCompany := cuUtil.FixDimensionSet("Dimension Set ID", bDimSetInserted, bDimSetModified);
                    if "Global Dimension 1 Code" <> shippingCompany then begin
                        "Global Dimension 1 Code" := shippingCompany;
                        Modify();
                        nFLEModified += 1;
                    end;
                    if bDimSetInserted then nDimSetInserted += 1;
                    if bDimSetModified then nDimSetModified += 1;
                    nFLEProcessed += 1;
                    progress.Update(12, nFLEProcessed);
                    progress.Update(13, nFLEModified);
                    progress.Update(14, nDimSetModified);
                    progress.Update(15, nDimSetInserted);
                end;

                trigger OnPostDataItem()
                begin
                end;
            }

            trigger onPreDataItem()
            begin
                progress.Open('Processing record #1######  \ ' +
                '(Entry #2###### out of #3######) \ ' +
                'G/L Entries Processed: #4###### \ ' +
                'G/L Entries Modified: #5###### \ ' +
                'Vendor Ledger Entries Processed: #6###### \ ' +
                'Vendor Ledger Entries:Modified: #7###### \ ' +
                'Cust. Ledger Entries:Processed: #8###### \ ' +
                'Cust. Ledger Entries Modified: #9###### \ ' +
                'Bank Ledger Entries Processed: #10###### \ ' +
                'Bank Ledger Entries Modified: #11###### \ ' +
                'FA Ledger Entries Processed: #12###### \ ' +
                'FA Ledger Entries Modified: #13###### \ ' +
                'Dimension Sets Modified: #14###### \ ' +
                'Dimension Sets Inserted: #15######');
                progress.Update(2, 0);
                progress.Update(3, Count());
                progress.Update(4, 0);
                progress.Update(5, 0);
                progress.Update(6, 0);
                progress.Update(7, 0);
                progress.Update(8, 0);
                progress.Update(9, 0);
                progress.Update(10, 0);
                progress.Update(11, 0);
                progress.Update(12, 0);
                progress.Update(13, 0);
                progress.Update(14, 0);
                progress.Update(15, 0);

            end;

            trigger OnAfterGetRecord()
            begin
                nGLRegisterProcessed += 1;
                progress.Update(1, "No.");
                progress.Update(2, nGLRegisterProcessed);
            end;

            trigger OnPostDataItem()
            begin
                progress.Close();
                MESSAGE(
                'G/L Register Entries Processed: %1 \ ' +
                'G/L Entries: Processed: %2 Modified %3  \  ' +
                'Vendor Ledger Entries: Processed: %4 Modified: %5 \ ' +
                'Cust. Ledger Entries: Processed: %6 Modified: %7 \ ' +
                'Bank Ledger Entries: Processed: %8 Modified: %9 \ ' +
                'FA Ledger Entries: Processed: %10 Modified: %11\ ' +
                'Dimension Sets: Modified: %12 Inserted: %13',
                nGLRegisterProcessed,
                nGLProcessed, nGLModified,
                nVLEProcessed, nVLEModified,
                nCLEProcessed, nCLEModified,
                nBLEProcessed, nBLEModified,
                nFLEProcessed, nFLEModified,
                nDimSetModified, nDimSetInserted);
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
        nGLProcessed: Integer;
        nGLModified: Integer;
        nVLEProcessed: Integer;
        nVLEModified: Integer;
        nCLEProcessed: Integer;
        nCLEModified: Integer;
        nBLEProcessed: Integer;
        nBLEModified: Integer;
        nFLEProcessed: Integer;
        nFLEModified: Integer;
        nDimSetModified: Integer;
        nDimSetInserted: Integer;
        bDimSetModified: Boolean;
        bDimSetInserted: Boolean;
        nGLRegisterProcessed: Integer;

        progress: Dialog;

        cuUtil: Codeunit DimUtilCU_GP;
}