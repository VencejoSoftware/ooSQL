{$REGION 'documentation'}
{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL condition syntax object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit SQLCondition;

interface

uses
  SysUtils,
  IterableList,
  SQLField,
  SQLParameter,
  Statement;

type
{$REGION 'documentation'}
{
  @abstract(SQL condition syntax object)
  Object to resolve a SQL sort syntax
  @member(
    Field Field to use with condition
    @return(@link(ISQLField Field object))
  )
  @member(
    IsValid Checks if the condition is valid to use
    @return(@true if the condition is valid, @false if not)
  )
}
{$ENDREGION}
  ISQLCondition = interface(IStatement)
    ['{D5E9B0B3-8909-4B3B-8DFD-886D8A78FB8F}']
    function Field: ISQLField;
    function IsValid: Boolean;
  end;

{$REGION 'documentation'}
{
  @abstract(SQL condition list object)
  List of conditions
  @member(
    Syntax Resolve as text
    @return(String with syntax)
  )
  @member(
    IsValid Checks if the condition is valid to use
    @return(@true if the condition is valid, @false if not)
  )
}
{$ENDREGION}

  ISQLConditionList = interface(IIterableList<ISQLCondition>)
    ['{9AF72119-76E2-47AE-887B-D406622F36FC}']
    function Syntax: String;
    function IsValid: Boolean;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ISQLConditionList))
  @member(Syntax @seealso(ISQLConditionList.Syntax))
  @member(IsValid @seealso(ISQLConditionList.IsValid))
  @member(Create Object constructor)
  @member(New Create a new @classname as interface)
}
{$ENDREGION}

  TSQLConditionList = class sealed(TIterableList<ISQLCondition>, ISQLConditionList)
  public
    function Syntax: String;
    function IsValid: Boolean;
    class function New: ISQLConditionList;
  end;

implementation

function TSQLConditionList.Syntax: String;
var
  Condition: ISQLCondition;
begin
  Result := EmptyStr;
  for Condition in Self do
    if Length(Result) > 0 then
      Result := Result + ' ' + Condition.Syntax
    else
      Result := Condition.Syntax;
  if Length(Result) > 0 then
    Result := '(' + Result + ')';
end;

function TSQLConditionList.IsValid: Boolean;
var
  Condition: ISQLCondition;
begin
  Result := not Self.IsEmpty;
  for Condition in Self do
    if not Condition.IsValid then
      Exit(False);
end;

class function TSQLConditionList.New: ISQLConditionList;
begin
  Result := TSQLConditionList.Create;
end;

end.
