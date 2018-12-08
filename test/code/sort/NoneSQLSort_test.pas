{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit NoneSQLSort_test;

interface

uses
  SysUtils,
  SQLSort,
  NoneSQLSort,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TNoneSQLSortTest = class sealed(TTestCase)
  published
    procedure KeyIsNil;
    procedure DirectionIsNone;
    procedure SyntaxIsEmpty;
  end;

implementation

procedure TNoneSQLSortTest.KeyIsNil;
begin
  CheckTrue(not Assigned(TNoneSQLSort.New.Key));
end;

procedure TNoneSQLSortTest.DirectionIsNone;
begin
  CheckEquals(Ord(TSQLSortDirection.None), Ord(TNoneSQLSort.New.Direction));
end;

procedure TNoneSQLSortTest.SyntaxIsEmpty;
begin
  CheckEquals(EmptyStr, TNoneSQLSort.New.Syntax);
end;

initialization

RegisterTest(TNoneSQLSortTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
