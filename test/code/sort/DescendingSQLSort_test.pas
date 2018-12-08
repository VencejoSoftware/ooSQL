{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit DescendingSQLSort_test;

interface

uses
  SysUtils,
  Key,
  SyntaxFormat, SyntaxFormatSymbol, SymbolListMock,
  SQLSort,
  DescendingSQLSort,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TDescendingSQLSortTest = class sealed(TTestCase)
  strict private
    _Sort: ISQLSort;
  public
    procedure SetUp; override;
  published
    procedure KeyIsField1;
    procedure DirectionIsDescending;
    procedure SyntaxField1Desc;
  end;

implementation

procedure TDescendingSQLSortTest.KeyIsField1;
begin
  CheckEquals('Field1', _Sort.Key.Value);
end;

procedure TDescendingSQLSortTest.DirectionIsDescending;
begin
  CheckEquals(Ord(TSQLSortDirection.Descending), Ord(_Sort.Direction));
end;

procedure TDescendingSQLSortTest.SyntaxField1Desc;
begin
  CheckEquals('Field1 DESC', _Sort.Syntax);
end;

procedure TDescendingSQLSortTest.SetUp;
begin
  inherited;
  _Sort := TDescendingSQLSort.New(TTextKey.New('Field1'), TSyntaxFormat.New(TSymbolListMock.New));
end;

initialization

RegisterTest(TDescendingSQLSortTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
