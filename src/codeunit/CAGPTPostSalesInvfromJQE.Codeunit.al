codeunit 50145 "CAGPT_Post Sales Inv. from JQE"
{
    TableNo = "Job Queue Entry";

    trigger OnRun()
    begin
        PostSalesinvoice(Rec."Parameter String");
    end;

    procedure PostSalesinvoice(SalesDocNoFilter: Text)
    var
        SalesHeader: Record "Sales Header";
        SalesPost: Codeunit "Sales-Post";
    begin
        Clear(SalesPost);
        SalesHeader.Reset();
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Invoice);
        SalesHeader.SetFilter("No.", SalesDocNoFilter);
        if SalesHeader.FindSet() then
            repeat
                SalesPost.Run(SalesHeader)
            until SalesHeader.Next() = 0;
    end;
}
