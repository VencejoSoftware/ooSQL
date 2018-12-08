{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit AscendingSQLSort_test;

interface

uses
  SysUtils,
  Key,
  SyntaxFormat, SyntaxFormatSymbol, SymbolListMock,
  SQLSort,
  AscendingSQLSort,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TAscendingSQLSortTest = class sealed(TTestCase)
  strict private
    _Sort: ISQLSort;
  public
    procedure SetUp; override;
  published
    procedure KeyIsField1;
    procedure DirectionIsAscending;
    procedure SyntaxField1Asc;
  end;

implementation

procedure TAscendingSQLSortTest.KeyIsField1;
begin
  CheckEquals('Field1', _Sort.Key.Value);
end;

procedure TAscendingSQLSortTest.DirectionIsAscending;
begin
  CheckEquals(Ord(TSQLSortDirection.Ascending), Ord(_Sort.Direction));
end;

procedure TAscendingSQLSortTest.SyntaxField1Asc;
begin
  CheckEquals('Field1 ASC', _Sort.Syntax);
end;

procedure TAscendingSQLSortTest.SetUp;
begin
  inherited;
  _Sort := TAscendingSQLSort.New(TTextKey.New('Field1'), TSyntaxFormat.New(TSymbolListMock.New));
end;

initialization

RegisterTest(TAscendingSQLSortTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
