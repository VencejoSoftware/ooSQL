{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit AscendingSQLSort_test;

interface

uses
  SysUtils,
  SQLField,
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
    procedure FieldIsField1;
    procedure DirectionIsAscending;
    procedure SyntaxField1Asc;
  end;

implementation

procedure TAscendingSQLSortTest.FieldIsField1;
begin
  CheckEquals('Field1', _Sort.Field.Name);
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
  _Sort := TAscendingSQLSort.New(TSQLField.New('Field1'));
end;

initialization

RegisterTest('Sort', TAscendingSQLSortTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
