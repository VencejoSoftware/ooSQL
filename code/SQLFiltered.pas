{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL with additional filter object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit SQLFiltered;

interface

uses
  SysUtils,
  Text,
  ReplaceText, InsensitiveWordMatch,
  Statement,
  SQLParameter,
  SQLFilter,
  SQLInjectedFilter,
  SQL;

type
{$REGION 'documentation'}
{
  @abstract(SQL with additional filter object)
  SQL parser with a dynamic filter object
  @member(
    Filter Additional filter object to apply when parse SQL raw text
    @return(Filter @link(ISQLFilter Filter object))
  )
}
{$ENDREGION}
  ISQLFiltered = interface(ISQL)
    ['{BCABFB83-2ED8-4E19-B700-723CAFDA6791}']
    function Filter: ISQLFilter;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ISQLFiltered))
  @member(Syntax @seealso(ISQL.Syntax))
  @member(Parse @seealso(ISQL.Parse))
  @member(Parse @seealso(ISQL.Parse))
  @member(Filter @seealso(ISQLFiltered.Filter))
  @member(
    ReplaceParameter Replace parameter in SQL raw text
    @param(SQL Raw SQL text)
    @param(Parameter @link(ISQLParameter Parameter object))
    @return(SQL string with parameter parsed)
  )
  @member(
    SQLWithFilter Parse SQL raw text adding the filter syntax
    @return(String with SQL and the filter syntax)
  )
  @member(
    Create Object constructor
    @param(SQL SQL raw text)
    @param(Filter @link(ISQLFilter Filter object))
  )
  @member(
    New Create a new @classname as interface
    @param(SQL SQL raw text)
    @param(Filter @link(ISQLFilter Filter object))
  )
}
{$ENDREGION}

  TSQLFiltered = class sealed(TInterfacedObject, ISQLFiltered)
  strict private
    _SQL: String;
    _Filter: ISQLFilter;
  private
    function SQLWithFilter: String;
  public
    function Syntax: String;
    function Parse(const Parameters: array of ISQLParameter): String; overload;
    function Parse(const Parameters: ISQLParameterList): String; overload;
    function Filter: ISQLFilter;
    constructor Create(const SQL: String; const Filter: ISQLFilter);
    class function New(const SQL: String; const Filter: ISQLFilter): ISQLFiltered;
  end;

implementation

function TSQLFiltered.Syntax: String;
begin
  Result := _SQL;
end;

function TSQLFiltered.Filter: ISQLFilter;
begin
  Result := _Filter;
end;

function TSQLFiltered.SQLWithFilter: String;
begin
  if Assigned(_Filter) and not _Filter.ConditionList.IsEmpty then
    Result := TSQLInjectedFilter.New.Parse(_SQL, _Filter)
  else
    Result := _SQL;
end;

function TSQLFiltered.Parse(const Parameters: array of ISQLParameter): String;
var
  SQL: ISQL;
begin
  SQL := TSQL.New(SQLWithFilter);
  Result := SQL.Parse(Parameters);
end;

function TSQLFiltered.Parse(const Parameters: ISQLParameterList): String;
var
  SQL: ISQL;
begin
  SQL := TSQL.New(SQLWithFilter);
  Result := SQL.Parse(Parameters);
end;

constructor TSQLFiltered.Create(const SQL: String; const Filter: ISQLFilter);
begin
  _SQL := SQL;
  _Filter := Filter;
end;

class function TSQLFiltered.New(const SQL: String; const Filter: ISQLFilter): ISQLFiltered;
begin
  Result := TSQLFiltered.Create(SQL, Filter);
end;

end.
