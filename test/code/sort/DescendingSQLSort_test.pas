{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit DescendingSQLSort_test;

interface

uses
  SysUtils,
  SQLField,
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
    procedure FieldIsField1;
    procedure DirectionIsDescending;
    procedure SyntaxField1Desc;
  end;

implementation

procedure TDescendingSQLSortTest.FieldIsField1;
begin
  CheckEquals('Field1', _Sort.Field.Name);
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
  _Sort := TDescendingSQLSort.New(TSQLField.New('Field1'));
end;

initialization

RegisterTest('Sort', TDescendingSQLSortTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
