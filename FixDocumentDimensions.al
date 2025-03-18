report 50002 "Fix Document Dimensions"
{
    ProcessingOnly = true;

    Permissions =
        tabledata "Purch. Inv. Header" = rm,
        tabledata "Purch. Inv. Line" = rm,
        tabledata "Purch. Cr. Memo Hdr." = rm,
        tabledata "Purch. Cr. Memo Line" = rm,
        tabledata "Sales Invoice Header" = rm,
        tabledata "Sales Invoice Line" = rm,
        tabledata "Sales Cr.Memo Header" = rm,
        tabledata "Sales Cr.Memo Line" = rm,
        tabledata "Bank Account" = rm,
        tabledata "Fixed Asset" = rm,

        tabledata "Dimension Set Entry" = rim;

    UsageCategory = None;

    ApplicationArea = All;
    Caption = 'Fix Document Dimensions';

    dataset
    {

        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            RequestFilterFields = "No.";
            trigger OnPreDataItem()
            begin
                progress.Update(1, Count());
            end;

            trigger OnAfterGetRecord()
            var
                shippingCompany: Code[20];
            begin
                shippingCompany := cuUtil.FixDimensionSet("Dimension Set ID", bDimInserted, bDimModified);
                if "Shortcut Dimension 1 Code" <> shippingCompany then begin
                    "Shortcut Dimension 1 Code" := shippingCompany;
                    Modify();
                end;
                nPInvHdr += 1;
                progress.Update(2, nPInvHdr);
            end;
        }
        dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
        {
            RequestFilterFields = "No.";
            trigger OnPreDataItem()
            begin
                progress.Update(3, Count());
            end;

            trigger OnAfterGetRecord()
            var
                shippingCompany: Code[20];
            begin
                shippingCompany := cuUtil.FixDimensionSet("Dimension Set ID", bDimInserted, bDimModified);
                if "Shortcut Dimension 1 Code" <> shippingCompany then begin
                    "Shortcut Dimension 1 Code" := shippingCompany;
                    Modify();
                end;
                nPInvLine += 1;
                progress.Update(4, nPInvLine);
            end;
        }
        dataitem("Purch. Cr. Memo Hdr."; "Purch. Cr. Memo Hdr.")
        {
            RequestFilterFields = "No.";
            trigger OnPreDataItem()
            begin
                progress.Update(5, Count());
            end;

            trigger OnAfterGetRecord()
            var
                shippingCompany: Code[20];
            begin
                shippingCompany := cuUtil.FixDimensionSet("Dimension Set ID", bDimInserted, bDimModified);
                if "Shortcut Dimension 1 Code" <> shippingCompany then begin
                    "Shortcut Dimension 1 Code" := shippingCompany;
                    Modify();
                end;
                nPCrMemoHdr += 1;
                progress.Update(6, nPCrMemoHdr);
            end;
        }

        dataitem("Purch. Cr. Memo Line"; "Purch. Cr. Memo Line")
        {
            RequestFilterFields = "No.";
            trigger OnPreDataItem()
            begin
                progress.Update(7, Count());
            end;

            trigger OnAfterGetRecord()
            var
                shippingCompany: Code[20];
            begin
                shippingCompany := cuUtil.FixDimensionSet("Dimension Set ID", bDimInserted, bDimModified);
                if "Shortcut Dimension 1 Code" <> shippingCompany then begin
                    "Shortcut Dimension 1 Code" := shippingCompany;
                    Modify();
                end;
                nPCrMemoLine += 1;
                progress.Update(8, nPCrMemoLine);
            end;
        }

        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            RequestFilterFields = "No.";
            trigger OnPreDataItem()
            begin
                progress.Update(9, Count());
            end;

            trigger OnAfterGetRecord()
            var
                shippingCompany: Code[20];
            begin
                shippingCompany := cuUtil.FixDimensionSet("Dimension Set ID", bDimInserted, bDimModified);
                if "Shortcut Dimension 1 Code" <> shippingCompany then begin
                    "Shortcut Dimension 1 Code" := shippingCompany;
                    Modify();
                end;
                nSInvHdr += 1;
                progress.Update(10, nSInvHdr);
            end;
        }

        dataitem("Sales Invoice Line"; "Sales Invoice Line")
        {
            RequestFilterFields = "No.";
            trigger OnPreDataItem()
            begin
                progress.Update(11, Count());
            end;

            trigger OnAfterGetRecord()
            var
                shippingCompany: Code[20];
            begin
                shippingCompany := cuUtil.FixDimensionSet("Dimension Set ID", bDimInserted, bDimModified);
                if "Shortcut Dimension 1 Code" <> shippingCompany then begin
                    "Shortcut Dimension 1 Code" := shippingCompany;
                    Modify();
                end;
                nSInvLine += 1;
                progress.Update(12, nSInvLine);
            end;
        }

        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            RequestFilterFields = "No.";
            trigger OnPreDataItem()
            begin
                progress.Update(13, Count());
            end;

            trigger OnAfterGetRecord()
            var
                shippingCompany: Code[20];
            begin
                shippingCompany := cuUtil.FixDimensionSet("Dimension Set ID", bDimInserted, bDimModified);
                if "Shortcut Dimension 1 Code" <> shippingCompany then begin
                    "Shortcut Dimension 1 Code" := shippingCompany;
                    Modify();
                end;
                nSCrMemoHdr += 1;
                progress.Update(14, nSCrMemoHdr);
            end;
        }

        dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
        {
            RequestFilterFields = "No.";
            trigger OnPreDataItem()
            begin
                progress.Update(15, Count());
            end;

            trigger OnAfterGetRecord()
            var
                shippingCompany: Code[20];
            begin
                shippingCompany := cuUtil.FixDimensionSet("Dimension Set ID", bDimInserted, bDimModified);
                if "Shortcut Dimension 1 Code" <> shippingCompany then begin
                    "Shortcut Dimension 1 Code" := shippingCompany;
                    Modify();
                end;
                nSCrMemoLine += 1;
                progress.Update(16, nSCrMemoLine);
            end;
        }
        dataitem("Fixed Asset"; "Fixed Asset")
        {
            RequestFilterFields = "No.";
            trigger OnPreDataItem()
            begin
                progress.Update(17, Count());
            end;

            trigger OnAfterGetRecord()
            var
                shippingCompany: Code[20];
            begin
                shippingCompany := cuUtil.getCompanyFromDefDim(Database::"Fixed Asset", "No.");
                Validate("Global Dimension 1 Code", shippingCompany);
                Modify(true);
                nFACount += 1;
                progress.Update(18, nFACount);
            end;
        }

        dataitem("Bank Account"; "Bank Account")
        {
            RequestFilterFields = "No.";
            trigger OnPreDataItem()
            begin
                progress.Update(19, Count());
            end;

            trigger OnAfterGetRecord()
            var
                shippingCompany: Code[20];
            begin
                shippingCompany := cuUtil.getCompanyFromDefDim(Database::"Bank Account", "No.");
                Validate("Bank Acc. Company FTN", shippingCompany);
                Modify(true);
                nBACount += 1;
                progress.Update(20, nFACount);
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
            'Purch. Inv. Header count: #1######  \ ' +
            'Processing #2######  \ ' +
            'Purch. Inv. Line count: #3######  \ ' +
            'Processing #4######  \ ' +
            'Purch. Cr. Memo Hdr. count: #5######  \ ' +
            'Processing #6######  \ ' +
            'Purch. Cr. Memo Line count: #7######  \ ' +
            'Processing #8######  \ ' +
            'Sales Invoice Header count: #9######  \ ' +
            'Processing #10######  \ ' +
            'Sales Invoice Line count: #11######  \ ' +
            'Processing #12######  \ ' +
            'Sales Cr.Memo Header count: #13######  \ ' +
            'Processing #14######  \ ' +
            'Sales Cr.Memo Line count: #15######  \ ' +
            'Processing #16######  \ ' +
            'Fixed Asset count: #17######  \ ' +
            'Processing #18######  \ ' +
            'Bank Account count: #19######  \ ' +
            'Processing #20######  \ ');
    end;

    trigger OnPostReport()
    begin
        progress.Close();
        MESSAGE(
            'Purch. Inv. Header: %1, Purch. Inv. Line: %2, ' +
            'Purch. Cr. Memo Hdr.: %3, Purch. Cr. Memo Line: %4, ' +
            'Sales Invoice Header: %5, Sales Invoice Line: %6, ' +
            'Sales Cr.Memo Header: %7, Sales Cr.Memo Line: %8, ' +
            'Fixed Asset: %9 ' +
            'Bank Account: %10',
            nPInvHdr, nPInvLine, nPCrMemoHdr, nPCrMemoLine,
            nSInvHdr, nSInvLine, nSCrMemoHdr, nSCrMemoLine,
            nFACount, nBACount);
    end;

    procedure FixPostedInvoiceDim(docNo: Code[20])
    var
        purchInvHeader: Record "Purch. Inv. Header";
        PurchInvLine: Record "Purch. Inv. Line";
        dimSetENTITY: Record "Dimension Set Entry";
        entityMapping: Record "CompanyMappingTable";
        shippingCompany: Code[20];
    begin
        purchInvHeader.Get(docNo);
        shippingCompany := cuUtil.FixDimensionSet(purchInvHeader."Dimension Set ID", bDimInserted, bDimModified);
        if purchInvHeader."Shortcut Dimension 1 Code" <> shippingCompany then begin
            purchInvHeader."Shortcut Dimension 1 Code" := shippingCompany;
            purchInvHeader.Modify();
        end;
    end;

    var
        documentNo: code[20];
        nPInvHdr: Integer;
        nPInvLine: Integer;
        nPCrMemoHdr: Integer;
        nPCrMemoLine: Integer;
        nSInvHdr: Integer;
        nSInvLine: Integer;
        nSCrMemoHdr: Integer;
        nSCrMemoLine: Integer;
        nFACount: Integer;
        nBACount: Integer;

        nDimSetInserted: Integer;
        bDimModified: Boolean;
        bDimInserted: Boolean;

        progress: Dialog;

        cuUtil: Codeunit DimUtilCU_GP;

}