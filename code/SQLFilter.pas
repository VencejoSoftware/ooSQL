{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL dynamic filter object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit SQLFilter;

interface

uses
  Key,
  Statement,
  SQLJoin,
  SyntaxFormat,
  SQLCondition;

type
{$REGION 'documentation'}
{
  @abstract(SQL dynamic filter object)
  SQL filter object oriented
  @member(
    Join Join syntax object
    @return(@link(ISQLJoin Join object))
  )
  @member(
    ConditionList List of conditions
    @return(@link(ISQLConditionList List of conditions))
  )
}
{$ENDREGION}
  ISQLFilter = interface(ISQLCondition)
    ['{AEEAC6C4-F3C8-4B9A-B96E-6B068B0A4E6A}']
    function Join: ISQLJoin;
    function ConditionList: ISQLConditionList;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ISQLFilter))
  @member(Key @seealso(ISQLCondition.Key))
  @member(Syntax @seealso(ISQLCondition.Syntax))
  @member(IsValid @seealso(ISQLCondition.IsValid))
  @member(Join @seealso(ISQLFilter.Join))
  @member(ConditionList @seealso(ISQLFilter.ConditionList))
  @member(
    Create Object constructor
    @param(Join @link(ISQLJoin Join object))
    @param(SyntaxFormat @link(ISQLJoin Syntax formatter object))
  )
  @member(
    New Create a new @classname as interface
    @param(Join @link(ISQLJoin Join object))
    @param(SyntaxFormat @link(ISQLJoin Syntax formatter object))
  )
}
{$ENDREGION}

  TSQLFilter = class sealed(TInterfacedObject, ISQLFilter)
  strict private
    _Join: ISQLJoin;
    _ConditionList: ISQLConditionList;
    _SyntaxFormat: ISyntaxFormat;
  public
    function Key: ITextKey;
    function Syntax: String;
    function IsValid: Boolean;
    function Join: ISQLJoin;
    function ConditionList: ISQLConditionList;
    constructor Create(const Join: ISQLJoin; const SyntaxFormat: ISyntaxFormat);
    class function New(const Join: ISQLJoin; const SyntaxFormat: ISyntaxFormat): ISQLFilter;
  end;

implementation

function TSQLFilter.Key: ITextKey;
begin
  Result := nil;
end;

function TSQLFilter.Join: ISQLJoin;
begin
  Result := _Join;
end;

function TSQLFilter.ConditionList: ISQLConditionList;
begin
  Result := _ConditionList;
end;

function TSQLFilter.Syntax: String;
begin
  Result := _SyntaxFormat.ItemsFormat([_Join.Syntax, _ConditionList.Syntax], [Spaced]);
end;

function TSQLFilter.IsValid: Boolean;
begin
  Result := _ConditionList.IsValid;
end;

constructor TSQLFilter.Create(const Join: ISQLJoin; const SyntaxFormat: ISyntaxFormat);
begin
  _ConditionList := TSQLConditionList.New(SyntaxFormat);
  _Join := Join;
  _SyntaxFormat := SyntaxFormat;
end;

class function TSQLFilter.New(const Join: ISQLJoin; const SyntaxFormat: ISyntaxFormat): ISQLFilter;
begin
  Result := TSQLFilter.Create(Join, SyntaxFormat);
end;

end.
