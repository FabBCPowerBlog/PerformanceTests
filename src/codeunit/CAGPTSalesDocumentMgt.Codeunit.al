codeunit 50140 "CAGPT_Sales Document Mgt"
{

    procedure CreateSalesDocFromTestTemplate(SalesDocType: enum "Sales Document Type"; TestTemplate: Record "CAGPT_Test Template"): Code[20];
    begin
        exit(CopySalesDocument(TestTemplate."Sales Document Type From", TestTemplate."From Document No.", SalesDocType, 1));
    end;

    procedure CopySalesDocument(FromDocType: Enum "Sales Document Type From"; FromDocNo: Code[20]; ToDocType: Enum "Sales Document Type"; DocQty: Integer): Code[20];
    var
        SalesHeader: Record "Sales Header";
        CopyDocMgt: Codeunit "Copy Document Mgt.";
        i: Integer;
    begin
        CopyDocMgt.SetProperties(true, false, false, true, true, false, false);
        for i := 1 to DocQty do begin
            SalesHeader.Init();
            SalesHeader."Document Type" := ToDocType;
            SalesHeader."No." := '';
            CopyDocMgt.CopySalesDoc(FromDocType, FromDocNo, SalesHeader);
        end;
        exit(SalesHeader."No.");
    end;

    procedure SwitchSalesInvoicePostingSetup(SalesInvoicePosting: Enum "Sales Invoice Posting")
    var
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        SalesSetup.get();
        SalesSetup.validate("Invoice Posting Setup", SalesInvoicePosting);
        SalesSetup.Modify(true);
    end;
}
