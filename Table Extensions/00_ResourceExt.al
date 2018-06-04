tableextension 123456700 ResourceExt extends Resource
{
    fields
    {
        field(123456701;"CSD_Resource Type";Option)
        {
            OptionMembers="Internal","External";
            OptionCaption='Internal,External';
            Caption='Resource Type';
        }
        field(123456702;"CSD_Maximum Participants";Integer)
        {
            Caption='Maximum Participants';
        }

        field(123456703;"CSD_Quantity Per Day";Decimal)
        {
            Caption='Quantity Per Day';
        }
        modify("Profit %") {
            trigger OnAfterValidate();
            var
            
            begin
                rec.TestField("Unit Cost");
            end;
        }
    }
    
    var
        myInt : Integer;
}