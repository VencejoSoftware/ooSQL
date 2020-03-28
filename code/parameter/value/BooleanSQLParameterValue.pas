{$REGION 'documentation'}
{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL boolean parameter content object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit BooleanSQLParameterValue;

interface

uses
  SQLParameterValue;

type
{$REGION 'documentation'}
{
  @abstract(SQL parameter boolean value syntax)
  Object to resolve a SQL parameter value with booleans
  @member(
    Value Boolean value
    @return(Boolean value)
  )
}
{$ENDREGION}
  IBooleanSQLParameterValue = interface(ISQLParameterValue)
    ['{612376F9-C4E5-481B-BE1C-EFD695B407E5}']
    function Value: Boolean;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IBooleanSQLParameterValue))
  Return the syntax value in '0' and '1' for false and true
  @member(Syntax @seealso(ISQLParameterValue.Syntax))
  @member(Content @seealso(IBooleanSQLParameterValue.Content))
  @member(
    Create Object constructor
    @param(Content Boolean value)
  )
  @member(
    New Create a new @classname as interface
    @param(Content Boolean value)
  )
}
{$ENDREGION}

  TBooleanSQLParameterValue = class sealed(TInterfacedObject, IBooleanSQLParameterValue)
  strict private
    _Value: Boolean;
  public
    function Content: String;
    function Value: Boolean;
    constructor Create(const Value: Boolean);
    class function New(const Value: Boolean): IBooleanSQLParameterValue;
  end;

implementation

function TBooleanSQLParameterValue.Content: String;
const
  BOOLEAN_VALUE: array [Boolean] of char = ('0', '1');
begin
  Result := BOOLEAN_VALUE[Value];
end;

function TBooleanSQLParameterValue.Value: Boolean;
begin
  Result := _Value;
end;

constructor TBooleanSQLParameterValue.Create(const Value: Boolean);
begin
  _Value := Value;
end;

class function TBooleanSQLParameterValue.New(const Value: Boolean): IBooleanSQLParameterValue;
begin
  Result := TBooleanSQLParameterValue.Create(Value);
end;

end.
