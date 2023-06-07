codeunit 50147 "CAGPT_Gen. Jnl. Test"
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
        exit('BATCH-GEN-JNL-POST');
    end;

    procedure Code(TestTemplate: Record "CAGPT_Test Template")
    var
        GLRegister: Record "G/L Register";
        GLEntry: Record "G/L Entry";
        JobQueueEntry: Record "Job Queue Entry";
        GeneralJournalMgt: codeunit CAGPT_GeneralJournalMgt;
        JnlBatchName: Code[10];
        JnlTemplateName: Code[10];
        MultipleStdGenJnlCode: Code[10];
        SingleStdGenJnlCode: Code[10];
        GLAccountToApply: Code[20];
    begin

        TestTemplate.TestField(Quantity);
        JnlTemplateName := TestTemplate.GetParameterValueAsCode10('JNLTEMPLATENAME');
        JnlBatchName := TestTemplate.GetParameterValueAsCode10('JNLBATCHNAME');
        MultipleStdGenJnlCode := TestTemplate.GetParameterValueAsCode10('MULTISTDGENJNLCODE');
        SingleStdGenJnlCode := TestTemplate.GetParameterValueAsCode10('SINGLESTDGENJNLCODE');
        GLAccountToApply := TestTemplate.GetParameterValueAsCode20('GLACCOUNTTOAPPLY');

        // Resetting Applies-to ID in All G/L Entries
        GLEntry.ModifyAll("CAGPC_Applies-to ID", '');
        Commit();

        // Filling General Journal
        GeneralJournalMgt.CreateGenJnlFromStdJnlMultipleTimes(JnlTemplateName, JnlBatchName, MultipleStdGenJnlCode, TestTemplate.Quantity);
        GeneralJournalMgt.CreateGenJnlFromStdJnlMultipleTimes(JnlTemplateName, JnlBatchName, SingleStdGenJnlCode, 1);

        // Posting General Journal
        GeneralJournalMgt.PostGeneralJournal(JnlTemplateName, JnlBatchName);

        // Updating the Applies-to ID in the Last generated Entries
        GLRegister.FindLast();
        GLEntry.SetRange("Entry No.", GLRegister."From Entry No.", GLRegister."To Entry No.");
        GLEntry.SetRange("G/L Account No.", GLAccountToApply);
        GLEntry.ModifyAll("CAGPC_Applies-to ID", UserId);

        // Enqueuing the appliance process
        JobQueueEntry.ScheduleJobQueueEntryWithParameters(Codeunit::"CAGPT_Apply GL Entr. from JQE", JobQueueEntry.RecordId, GLAccountToApply);

    end;
}
