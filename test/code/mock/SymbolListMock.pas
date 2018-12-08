{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit SymbolListMock;

interface

uses
  SyntaxFormatSymbol;

type
  TSymbolListMock = class sealed(TInterfacedObject, ISyntaxFormatSymbolList)
  strict private
    _SymbolList: ISyntaxFormatSymbolList;
  public
    function Symbol(const Code: TSyntaxFormatSymbolCode): String;
    procedure Add(const Symbol: ISyntaxFormatSymbol);
    constructor Create;
    class function New: ISyntaxFormatSymbolList;
  end;

implementation

procedure TSymbolListMock.Add(const Symbol: ISyntaxFormatSymbol);
begin
  _SymbolList.Add(Symbol);
end;

function TSymbolListMock.Symbol(const Code: TSyntaxFormatSymbolCode): String;
begin
  Result := _SymbolList.Symbol(Code);
end;

constructor TSymbolListMock.Create;
begin
  _SymbolList := TSyntaxFormatSymbolList.New;
  _SymbolList.Add(TSyntaxFormatSymbol.New(Separator, ','));
  _SymbolList.Add(TSyntaxFormatSymbol.New(DelimiterStarter, '"'));
  _SymbolList.Add(TSyntaxFormatSymbol.New(DelimiterFinisher, '"'));
  _SymbolList.Add(TSyntaxFormatSymbol.New(Indentator, #9));
  _SymbolList.Add(TSyntaxFormatSymbol.New(Spacer, ' '));
  _SymbolList.Add(TSyntaxFormatSymbol.New(ListStarter, '('));
  _SymbolList.Add(TSyntaxFormatSymbol.New(ListFinisher, ')'));
  _SymbolList.Add(TSyntaxFormatSymbol.New(WordWrapper, sLineBreak));
end;

class function TSymbolListMock.New: ISyntaxFormatSymbolList;
begin
  Result := TSymbolListMock.Create;
end;

end.
