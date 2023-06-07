codeunit 50146 "CAGPT_Sales Inv. Post. Test"
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::CAGPT_TestLaunchMgt, 'OnMakeCreateNewTestTemplateMenu', '', false, false)]
    local procedure OnMakeCreateNewTestTemplateMenu(var TestCodeList: List of [Code[20]]);
    begin
        TestCodeList.Add(GetDefaultSetupCode());
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::CAGPT_TestLaunchMgt, 'OnTestLaunch', '', false, false)]
    local procedure OnTestLaunch(TestTemplate: Record "CAGPT_Test Template")
    begin
        if TestTemplate.Code = GetDefaultSetupCode() then
            Code(TestTemplate);
    end;

    local procedure GetDefaultSetupCode(): Code[20]
    begin
        exit('BATCH-SALES-INV-POST');
    end;

    procedure Code(TestTemplate: Record "CAGPT_Test Template")
    var
        JobQueueEntry: Record "Job Queue Entry";
        SalesDocMgt: Codeunit "CAGPT_Sales Document Mgt";
        FromDocumentNo: Code[20];
        FirstDocumentNo: Code[20];
        LastDocumentNo: Code[20];
    begin
        TestTemplate.TestField(Quantity);
        FromDocumentNo := TestTemplate.GetParameterValueAsCode20('FROMINVOICENO');
        FirstDocumentNo := SalesDocMgt.CopySalesDocumentMultipleTimes(Enum::"Sales Document Type From"::Invoice, FromDocumentNo, Enum::"Sales Document Type"::Invoice, 1);
        LastDocumentNo := SalesDocMgt.CopySalesDocumentMultipleTimes(Enum::"Sales Document Type From"::Invoice, FirstDocumentNo, Enum::"Sales Document Type"::Invoice, TestTemplate.Quantity);
        JobQueueEntry.ScheduleJobQueueEntryWithParameters(Codeunit::"CAGPT_Post Sales Inv. from JQE", JobQueueEntry.RecordId, Strsubstno('%1..%2', FirstDocumentNo, LastDocumentNo));
    end;

}
