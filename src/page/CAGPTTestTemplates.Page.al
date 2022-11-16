page 50140 "CAGPT_Test Templates"
{
    ApplicationArea = All;
    Caption = 'Test Templates';
    PageType = List;
    SourceTable = "CAGPT_Test Template";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("Sales Document Type From"; Rec."Sales Document Type From")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("From Document No."; Rec."From Document No.")
                {
                    ToolTip = 'Specifies the value of the From Document No. field.';
                }
                field("Document Count"; Rec."Document Count")
                {
                    ToolTip = 'Specifies the value of the Document Count field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(LaunchTest)
            {
                Caption = 'Launch Tests';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = Basic, Suite;
                Image = ReleaseDoc;

                trigger OnAction()
                var
                    TestLaunchMgt: Codeunit CAGPT_TestLaunchMgt;
                begin
                    TestLaunchMgt.LaunchTest(Rec);
                end;
            }

        }
        area(navigation)
        {
            action(OpenJobQueueEntries)
            {
                Caption = 'Open Job Queue Entries';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = Basic, Suite;
                RunObject = page "Job Queue Entries";
            }
            action(OpenJobQueueLogEntries)
            {
                Caption = 'Open Job Queue Log Entries';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = Basic, Suite;
                RunObject = page "Job Queue Log Entries";
            }
        }
    }
}