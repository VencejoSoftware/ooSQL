{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQL;

interface

uses
  SysUtils,
  ooText.Replace, ooText.Match.WordInsensitive,
  ooFilter,
  ooSort,
  ooText.Beautify.Intf,
  ooSQL.Filter.Inject,
  ooSQL.Parameter.Intf, ooSQL.Intf;

type
  TSQL = class sealed(TInterfacedObject, ISQL)
  strict private
    _SQL: String;
    _Filter: IFilter;
    _Sort: ISort;
  private
    function ReplaceParameter(const SQL: String; const Parameter: ISQLParameter): String;
    function ApplyFilter(const SQL: String; const Beautify: ITextBeautify): String;
  public
    function SQL: String;
    function Parse(const Parameters: array of ISQLParameter; const Beautify: ITextBeautify): String;

    constructor Create(const SQL: String; const Filter: IFilter; const Sort: ISort);

    class function New(const SQL: String; const Filter: IFilter = nil; const Sort: ISort = nil): ISQL;
  end;

implementation

function TSQL.SQL: String;
begin
  Result := _SQL;
end;

function TSQL.ReplaceParameter(const SQL: String; const Parameter: ISQLParameter): String;
begin
  Result := TTextReplace.NewFromString(SQL, TTextMatchWordInsensitive.New).AllMatches(Parameter.NameParsed,
    Parameter.ValueParsed)
end;

function TSQL.ApplyFilter(const SQL: String; const Beautify: ITextBeautify): String;
begin
  if Assigned(_Filter) then
    Result := TSQLWhereInjected.New(SQL).Parse(_Filter, Beautify)
  else
    Result := SQL;
end;

function TSQL.Parse(const Parameters: array of ISQLParameter; const Beautify: ITextBeautify): String;
var
  Parameter: ISQLParameter;
begin
  Result := SQL;
  for Parameter in Parameters do
    Result := ReplaceParameter(Result, Parameter);
  Result := ApplyFilter(Result, Beautify);
end;

constructor TSQL.Create(const SQL: String; const Filter: IFilter; const Sort: ISort);
begin
  _SQL := SQL;
  _Filter := Filter;
  _Sort := Sort;
end;

class function TSQL.New(const SQL: String; const Filter: IFilter; const Sort: ISort): ISQL;
begin
  Result := TSQL.Create(SQL, Filter, Sort);
end;

end.
