codeunit 50146 "CAGPT_Sales Inv. Post. Test"
{
    var
        SalesDocMgt: Codeunit "CAGPT_Sales Document Mgt";

    [EventSubscriber(ObjectType::Codeunit, codeunit::CAGPT_TestLaunchMgt, 'OnMakeTestLaunchMenu', '', false, false)]
    local procedure OnMakeTestLaunchMenu(var StrMenuString: Text)
    var
        DocExchSetupMgt: Codeunit CAGPT_TestLaunchMgt;
    begin
        DocExchSetupMgt.AddStringToStrMenuString(StrMenuString, GetDefaultSetupCode());
    end;


    [EventSubscriber(ObjectType::Codeunit, codeunit::CAGPT_TestLaunchMgt, 'OnTestLaunch', '', false, false)]
    local procedure OnTestLaunch(TestCode: Text; TestTemplate: Record "CAGPT_Test Template")
    begin
        if TestCode = GetDefaultSetupCode() then
            CreateSalesInvoicesAndEnqueuePosting(TestTemplate);
    end;

    local procedure GetDefaultSetupCode(): Text
    begin
        exit('MASS-SALES-INVOICE-POST');
    end;

    procedure CreateSalesInvoicesAndEnqueuePosting(TestTemplate: Record "CAGPT_Test Template")
    var
        JobQueueEntry: Record "Job Queue Entry";
        FirstDocumentNo: Code[20];
        LastDocumentNo: Code[20];
    begin
        TestTemplate.TestField("From Document No.");
        TestTemplate.TestField("Document Count");
        case StrMenu('v19,Default') of
            1:
                SalesDocMgt.SwitchSalesInvoicePostingSetup(Enum::"Sales Invoice Posting"::"Invoice Posting (v.19)");
            2:
                SalesDocMgt.SwitchSalesInvoicePostingSetup(Enum::"Sales Invoice Posting"::"Invoice Posting (Default)");
        end;
        FirstDocumentNo := SalesDocMgt.CreateSalesDocFromTestTemplate(Enum::"Sales Document Type"::Invoice, TestTemplate);
        LastDocumentNo := SalesDocMgt.CopySalesDocument(Enum::"Sales Document Type From"::Invoice, FirstDocumentNo, Enum::"Sales Document Type"::Invoice, TestTemplate."Document Count");
        JobQueueEntry.ScheduleJobQueueEntryWithParameters(Codeunit::"CAGPT_Post Sales Inv. from JQE", JobQueueEntry.RecordId, Strsubstno('%1..%2', FirstDocumentNo, LastDocumentNo));
    end;
}
