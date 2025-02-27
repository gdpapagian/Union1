report 50005 "Fix Company Pictures"
{
    ProcessingOnly = true;

    UsageCategory = None;

    ApplicationArea = All;
    Caption = 'Fix Company Pictures';

    dataset
    {
        dataitem("Company FTN"; "Company FTN")
        {
            trigger onPreDataItem()
            begin
                progress.Open(
                'Maritime Companies: #1###### \ ' +
                'Maritime Companies Processed: #2###### ');
                progress.Update(1, Count());
                progress.Update(2, 0);
            end;


            trigger OnAfterGetRecord()
            var
                shippingCompany: Code[20];
            begin
                f_ImportPicture("Company FTN");
                nCompanyFTN += 1;
                progress.Update(2, nCompanyFTN);
            end;



            trigger OnPostDataItem()
            begin
                progress.Close();
                MESSAGE(
                'Maritime Companies Processed: %1 \ ',
                nCompanyFTN);
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

                }
            }
        }
    }


    trigger OnPreReport()
    var
        cuL_FileManagement: Codeunit "File Management";
        txtL_FileName: Text;
        ImportTxt: Label 'Import Bitmap';
        FileDialogTxt: Label 'BMP files (*.bmp)|*.bmp';
        FilterTxt: Label '*.bmp', Locked = true;
    begin
        //txtL_FileName := cuL_FileManagement.BLOBImportWithFilter(
        //    cuG_TempBlob, ImportTxt, txtL_FileName, StrSubstNo(FileDialogTxt, FilterTxt), FilterTxt);
        txtL_FileName := cuL_FileManagement.BLOBImport(
                cuG_TempBlob, 'All files');
    end;

    trigger OnPostReport()
    begin
    end;

    var
        nCompanyFTN: Integer;
        cuG_TempBlob: Codeunit "Temp Blob";
        progress: Dialog;
        FilePath: Text[250];

    internal procedure f_ImportPicture(var Rec: Record "Company FTN")
    var
        rrefL_RecordRef: RecordRef;
    begin
        rrefL_RecordRef.GetTable(Rec);
        cuG_TempBlob.ToRecordRef(rrefL_RecordRef, Rec.FieldNo(Picture));
        rrefL_RecordRef.Modify;
    end;
}