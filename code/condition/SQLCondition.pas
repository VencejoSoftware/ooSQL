{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
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
  Key,
  SyntaxFormat,
  SQLParameter,
  IterableList,
  Statement;

type
{$REGION 'documentation'}
{
  @abstract(SQL condition syntax object)
  Object to resolve a SQL sort syntax
  @member(
    Key Field to use with condition
    @return(@link(ITextKey Key field))
  )
  @member(
    IsValid Checks if the condition is valid to use
    @return(@true if the condition is valid, @false if not)
  )
}
{$ENDREGION}
  ISQLCondition = interface(IStatement)
    ['{D5E9B0B3-8909-4B3B-8DFD-886D8A78FB8F}']
    function Key: ITextKey;
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
  @member(
    Create Object constructor
    @param(SyntaxFormat @link(ISQLJoin Syntax formatter object))
  )
  @member(
    New Create a new @classname as interface
    @param(SyntaxFormat @link(ISQLJoin Syntax formatter object))
  )
}
{$ENDREGION}

  TSQLConditionList = class sealed(TIterableList<ISQLCondition>, ISQLConditionList)
  strict private
    _SyntaxFormat: ISyntaxFormat;
  public
    function Syntax: String;
    function IsValid: Boolean;
    constructor Create(const SyntaxFormat: ISyntaxFormat); reintroduce;
    class function New(const SyntaxFormat: ISyntaxFormat): ISQLConditionList;
  end;

implementation

function TSQLConditionList.Syntax: String;
var
  Condition: ISQLCondition;
begin
  Result := EmptyStr;
  for Condition in Self do
    Result := _SyntaxFormat.ItemsFormat([Result, Condition.Syntax], [Spaced]);
  Result := _SyntaxFormat.TextFormat(Result, [Enclosed]);
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

constructor TSQLConditionList.Create(const SyntaxFormat: ISyntaxFormat);
begin
  inherited Create;
  _SyntaxFormat := SyntaxFormat;
end;

class function TSQLConditionList.New(const SyntaxFormat: ISyntaxFormat): ISQLConditionList;
begin
  Result := TSQLConditionList.Create(SyntaxFormat);
end;

end.
