{$REGION 'documentation'}
{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL IN condition syntax object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit InSQLCondition;

interface

uses
  SysUtils,
  SQLField,
  AndSQLJoin,
  SQLParameter,
  SQLCondition;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ISQLCondition))
  Resolve SQL IN condition as syntax. For example: [FIELD] IN ([PARAMETER1]..[PARAMETERN])
  @member(Field @seealso(ISQLCondition.Field))
  @member(Syntax @seealso(ISQLCondition.Syntax))
  @member(
    Validate all paramters and exit if one is false
    IsValid @seealso(ISQLCondition.IsValid)
  )
  @member(
    PlainParameters Parse parameters syntax as simple text
    @return(Text with syntax parameters)
  )
  @member(
    Create Object constructor
    @param(Field Condition field)
    @param(Parameters Array of parameter object)
  )
  @member(
    New Create a new @classname as interface
    @param(Field Condition field)
    @param(Parameters Array of parameter object)
  )
}
{$ENDREGION}
  TInSQLCondition = class sealed(TInterfacedObject, ISQLCondition)
  strict private
    _Field: ISQLField;
    _Parameters: Array of ISQLParameter;
  private
    function PlainParameters: String;
  public
    function Field: ISQLField;
    function Syntax: String;
    function IsValid: Boolean;
    constructor Create(const Field: ISQLField; const Parameters: Array of ISQLParameter);
    class function New(const Field: ISQLField; const Parameters: Array of ISQLParameter): ISQLCondition;
  end;

implementation

function TInSQLCondition.Field: ISQLField;
begin
  Result := _Field;
end;

function TInSQLCondition.PlainParameters: String;
var
  Item: ISQLParameter;
begin
  Result := EmptyStr;
  for Item in _Parameters do
    Result := Result + Item.Value.Content + ',';
  Result := '(' + Copy(Result, 1, Pred(Length(Result))) + ')';
end;

function TInSQLCondition.Syntax: String;
begin
  Result := _Field.Name + ' IN ' + PlainParameters;
end;

function TInSQLCondition.IsValid: Boolean;
var
  Item: ISQLParameter;
begin
  Result := False;
  for Item in _Parameters do
  begin
    Result := Assigned(Item) and not Item.IsNull;
    if not Result then
      Exit(False);
  end;
end;

constructor TInSQLCondition.Create(const Field: ISQLField; const Parameters: Array of ISQLParameter);
var
  i: Integer;
begin
  _Field := Field;
  SetLength(_Parameters, Length(Parameters));
  for i := 0 to High(Parameters) do
    _Parameters[i] := Parameters[i];
end;

class function TInSQLCondition.New(const Field: ISQLField; const Parameters: Array of ISQLParameter): ISQLCondition;
begin
  Result := TInSQLCondition.Create(Field, Parameters);
end;

end.
