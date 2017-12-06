{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQL.Filter.JoinNone_test;

interface

uses
  SysUtils,
  ooSQL.Filter.SimpleFormatter,
  ooSQL.Filter.JoinNone,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TSQLFilterJoinNoneTest = class(TTestCase)
  published
    procedure NoneParse;
    procedure NoneIsEmpty;
    procedure NoneIsReplaceable;
  end;

implementation

procedure TSQLFilterJoinNoneTest.NoneIsEmpty;
begin
  CheckFalse(TSQLJoinNone.New.IsEmpty);
end;

procedure TSQLFilterJoinNoneTest.NoneIsReplaceable;
begin
  CheckFalse(TSQLJoinNone.New.IsReplaceable);
end;

procedure TSQLFilterJoinNoneTest.NoneParse;
begin
  CheckEquals(EmptyStr, TSQLJoinNone.New.Parse(TSQLFilterSimpleFormatter.New));
end;

initialization

RegisterTest(TSQLFilterJoinNoneTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
