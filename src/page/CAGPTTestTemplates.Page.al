page 50140 "CAGPT_Test Templates"
{
    ApplicationArea = All;
    Caption = 'Test Templates';
    PageType = List;
    SourceTable = "CAGPT_Test Template";
    UsageCategory = Lists;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    Editable = false;
                }
                field("Version"; Rec."Version")
                {
                    ToolTip = 'Specifies the value of the Version field.';
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(CreateTest)
            {
                Caption = 'Create Test';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = Basic, Suite;
                Image = New;

                trigger OnAction()
                var
                    TestLaunchMgt: Codeunit CAGPT_TestLaunchMgt;
                begin
                    TestLaunchMgt.CreateNewTestTemplate();
                end;
            }
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
            action(Parameters)
            {
                Caption = 'Parameters';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = Basic, Suite;
                Image = ValueLedger;

                trigger OnAction()
                begin
                    Rec.ShowParameters();
                end;
            }
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