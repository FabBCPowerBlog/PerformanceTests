codeunit 50140 "CAGPT_Sales Document Mgt"
{

    procedure CopySalesDocumentMultipleTimes(FromDocType: Enum "Sales Document Type From"; FromDocNo: Code[20]; ToDocType: Enum "Sales Document Type"; Qty: Integer): Code[20];
    var
        SalesHeader: Record "Sales Header";
        CopyDocMgt: Codeunit "Copy Document Mgt.";
        i: Integer;
    begin
        CopyDocMgt.SetProperties(true, false, false, true, true, false, false);
        for i := 1 to Qty do begin
            SalesHeader.Init();
            SalesHeader."Document Type" := ToDocType;
            SalesHeader."No." := '';
            CopyDocMgt.CopySalesDoc(FromDocType, FromDocNo, SalesHeader);
        end;
        exit(SalesHeader."No.");
    end;

    procedure PostSalesDocuments(SalesDocType: enum "Sales Document Type"; SalesDocNoFilter: Text)
    var
        SalesHeader: Record "Sales Header";
        SalesPost: Codeunit "Sales-Post";
    begin
        Clear(SalesPost);
        SalesHeader.SetRange("Document Type", SalesDocType);
        SalesHeader.SetFilter("No.", SalesDocNoFilter);
        if SalesHeader.FindSet() then
            repeat
                SalesPost.Run(SalesHeader)
            until SalesHeader.Next() = 0;
    end;

}
