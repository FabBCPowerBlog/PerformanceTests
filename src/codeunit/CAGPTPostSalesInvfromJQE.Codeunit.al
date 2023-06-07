codeunit 50145 "CAGPT_Post Sales Inv. from JQE"
{
    TableNo = "Job Queue Entry";

    trigger OnRun()
    var
        SalesDocMgt: Codeunit "CAGPT_Sales Document Mgt";
    begin
        SalesDocMgt.PostSalesDocuments(Enum::"Sales Document Type"::Invoice, Rec."Parameter String");
    end;
}