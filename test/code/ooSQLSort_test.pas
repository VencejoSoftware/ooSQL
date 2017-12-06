{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQLSort_test;

interface

uses
  SysUtils,
  ooText.Beautify.Simple,
  ooSort.Order.Intf,
  ooSQL.Sort.Order.Ascending, ooSQL.Sort.Order.Descending, ooSQL.Sort.Order.None,
  ooSort,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TSortTest = class(TTestCase)
  published
    procedure SortAscIsOk;
    procedure SortDescIsOk;
    procedure TwoOrderText;
  end;

implementation

procedure TSortTest.SortAscIsOk;
begin
  CheckEquals('Field1', TSQLSortOrderAsc.New('Field1').Key);
  CheckTrue(TSQLSortOrderAsc.New('Field1').Direction = sodAscending);
end;

procedure TSortTest.SortDescIsOk;
begin
  CheckEquals('Field1', TSQLSortOrderDesc.New('Field1').Key);
  CheckTrue(TSQLSortOrderDesc.New('Field1').Direction = sodDescending);
end;

procedure TSortTest.TwoOrderText;
var
  Sort: ISort;
begin
  Sort := TSort.New;
  Sort.AddOrder(TSQLSortOrderAsc.New('Field1'));
  Sort.AddOrder(TSQLSortOrderDesc.New('Field2'));
  CheckEquals('Field1 ASC , Field2 DESC', Sort.Parse(TSimpleBeautify.New));
end;

initialization

RegisterTest(TSortTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
