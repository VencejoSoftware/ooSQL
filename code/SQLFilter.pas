{$REGION 'documentation'}
{
  Copyright (c) 2020, Vencejo Software
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
  Statement,
  SQLField,
  SQLJoin,
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
  @member(Field @seealso(ISQLCondition.Field))
  @member(Syntax @seealso(ISQLCondition.Syntax))
  @member(IsValid @seealso(ISQLCondition.IsValid))
  @member(Join @seealso(ISQLFilter.Join))
  @member(ConditionList @seealso(ISQLFilter.ConditionList))
  @member(
    Create Object constructor
    @param(Join @link(ISQLJoin Join object))
  )
  @member(
    New Create a new @classname as interface
    @param(Join @link(ISQLJoin Join object))
  )
}
{$ENDREGION}

  TSQLFilter = class sealed(TInterfacedObject, ISQLFilter)
  strict private
    _Join: ISQLJoin;
    _ConditionList: ISQLConditionList;
  public
    function Field: ISQLField;
    function Syntax: String;
    function IsValid: Boolean;
    function Join: ISQLJoin;
    function ConditionList: ISQLConditionList;
    constructor Create(const Join: ISQLJoin);
    class function New(const Join: ISQLJoin): ISQLFilter;
  end;

implementation

function TSQLFilter.Field: ISQLField;
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
  Result := _Join.Syntax;
  if Length(Result) > 0 then
    Result := Result + ' ';
  Result := Result + _ConditionList.Syntax;
end;

function TSQLFilter.IsValid: Boolean;
begin
  Result := _ConditionList.IsValid;
end;

constructor TSQLFilter.Create(const Join: ISQLJoin);
begin
  _ConditionList := TSQLConditionList.New;
  _Join := Join;
end;

class function TSQLFilter.New(const Join: ISQLJoin): ISQLFilter;
begin
  Result := TSQLFilter.Create(Join);
end;

end.
