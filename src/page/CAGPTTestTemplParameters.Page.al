page 50141 "CAGPT_Test Templ. Parameters"
{
    ApplicationArea = All;
    Caption = 'Test Templ. Parameters';
    PageType = List;
    SourceTable = "CAGPT_Test Template Parameter";
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
                field("Value"; Rec."Value")
                {
                    ToolTip = 'Specifies the value of the Value field.';
                }
            }
        }
    }
}
