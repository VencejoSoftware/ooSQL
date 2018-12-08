{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL inject filter object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit SQLInjectedFilter;

interface

uses
  SysUtils,
  SQLFilter,
  Text,
  TextMatch, ReverseTextMatch,
  TextLocation,
  DividedText;

type
  ISQLInjectedFilter = interface
    ['{C36323A3-9533-449D-9BB0-BA26455030F4}']
    function Parse(const SQL: String; const Filter: ISQLFilter): String;
  end;

  TSQLInjectedFilter = class sealed(TInterfacedObject, ISQLInjectedFilter)
  const
    SPACER = ' ';
    WHERE = 'WHERE';
    ORDER_BY = 'ORDER BY';
  private
    function FindWhere(const SQL: IText): Cardinal;
    function FindOrderBy(const SQL: IText): Cardinal;
    function AppendFilter(const SQL: IText; const Filter: ISQLFilter): String;
  public
    function Parse(const SQL: String; const Filter: ISQLFilter): String;
    class function New: ISQLInjectedFilter;
  end;

implementation

function TSQLInjectedFilter.FindOrderBy(const SQL: IText): Cardinal;
var
  FindReverse: ITextMatch;
  Location: ITextLocation;
begin
  FindReverse := TReverseTextMatch.New;
  Location := FindReverse.Find(SQL, TText.New(ORDER_BY), 1);
  if not Assigned(Location) then
    Result := 0
  else
    Result := Location.StartAt;
end;

function TSQLInjectedFilter.FindWhere(const SQL: IText): Cardinal;
var
  FindReverse: ITextMatch;
  Location: ITextLocation;
begin
  FindReverse := TReverseTextMatch.New;
  Location := FindReverse.Find(SQL, TText.New(WHERE), 1);
  if not Assigned(Location) then
    Result := 0
  else
    Result := Location.StartAt;
end;

function TSQLInjectedFilter.AppendFilter(const SQL: IText; const Filter: ISQLFilter): String;
var
  WherePos: Integer;
begin
  WherePos := FindWhere(SQL);
  if WherePos > 0 then
    Result := SQL.Value + SPACER + Filter.Syntax
  else
    Result := SQL.Value + SPACER + WHERE + SPACER + Filter.Syntax;
end;

function TSQLInjectedFilter.Parse(const SQL: String; const Filter: ISQLFilter): String;
var
  OrderByPos: Integer;
  TextCutted: IDividedText;
  Syntax: IText;
begin
  Syntax := TText.New(SQL);
  OrderByPos := FindOrderBy(Syntax);
  if OrderByPos > 0 then
  begin
    TextCutted := TDividedText.New(Syntax.Value, Pred(OrderByPos));
    Result := AppendFilter(TText.New(Trim(TextCutted.LeftPart)), Filter) + SPACER + TextCutted.RightPart;
  end
  else
    Result := AppendFilter(Syntax, Filter);
end;

class function TSQLInjectedFilter.New: ISQLInjectedFilter;
begin
  Result := TSQLInjectedFilter.Create;
end;

end.
