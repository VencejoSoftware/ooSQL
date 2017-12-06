unit ooSQL.Filter.Inject;

interface

uses
  SysUtils,
  ooFilter,
  ooText.Beautify.Intf,
  ooText.Match.Intf, ooText.Match.Reverse,
  ooText.Cutted;

type
  ISQLFilterInject = interface
    ['{4F613865-8FC2-4C22-9821-6745B63F8481}']
    function Parse(const Filter: IFilter; const Beautify: ITextBeautify): String;
  end;

  TSQLWhereInjected = class sealed(TInterfacedObject, ISQLFilterInject)
  const
    WHERE = 'WHERE';
    ORDER_BY = 'ORDER BY';
  strict private
    _SQL: String;
  private
    function FindWhere: Integer;
    function FindOrderBy: Integer;
    function AppendFilter(const Text: String; const Filter: IFilter; const Beautify: ITextBeautify): String;
  public
    function Parse(const Filter: IFilter; const Beautify: ITextBeautify): String;
    constructor Create(const SQL: String);
    class function New(const SQL: String): ISQLFilterInject;
  end;

implementation

function TSQLWhereInjected.FindOrderBy: Integer;
var
  FindReverse: ITextMatch;
begin
  FindReverse := TTextFindReverse.New;
  FindReverse.Find(_SQL, ORDER_BY, 0);
  Result := FindReverse.FoundStart;
end;

function TSQLWhereInjected.FindWhere: Integer;
var
  FindReverse: ITextMatch;
begin
  FindReverse := TTextFindReverse.New;
  FindReverse.Find(_SQL, WHERE, 0);
  Result := FindReverse.FoundStart;
end;

function TSQLWhereInjected.AppendFilter(const Text: String; const Filter: IFilter;
  const Beautify: ITextBeautify): String;
var
  WherePos: Integer;
begin
  WherePos := FindWhere;
  if WherePos > 0 then
    Result := Beautify.Apply([Text, Filter.Parse(Beautify)])
  else
    Result := Beautify.Apply([Text, WHERE, Beautify.DelimitedList(Filter.Elements.Parse(Beautify))]);
end;

function TSQLWhereInjected.Parse(const Filter: IFilter; const Beautify: ITextBeautify): String;
var
  OrderByPos: Integer;
  TextCutted: ITextCutted;
begin
  OrderByPos := FindOrderBy;
  if OrderByPos > 0 then
  begin
    TextCutted := TTextCutted.New(_SQL, Pred(OrderByPos));
    Result := AppendFilter(Trim(TextCutted.FirstPart), Filter, Beautify) + ' ' + TextCutted.EndPart;
  end
  else
    Result := AppendFilter(_SQL, Filter, Beautify);
end;

constructor TSQLWhereInjected.Create(const SQL: String);
begin
  _SQL := SQL;
end;

class function TSQLWhereInjected.New(const SQL: String): ISQLFilterInject;
begin
  Result := TSQLWhereInjected.Create(SQL);
end;

end.
