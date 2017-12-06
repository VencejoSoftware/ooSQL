{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQL.Filter.JoinOrNot_test;

interface

uses
  SysUtils,
  ooSQL.Filter.SimpleFormatter,
  ooSQL.Filter.JoinOrNot,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TSQLFilterJoinOrNotTest = class(TTestCase)
  published
    procedure OrNotParse;
    procedure OrNotIsEmpty;
    procedure OrNotIsReplaceable;
  end;

implementation

procedure TSQLFilterJoinOrNotTest.OrNotIsEmpty;
begin
  CheckFalse(TSQLJoinOrNot.New.IsEmpty);
end;

procedure TSQLFilterJoinOrNotTest.OrNotIsReplaceable;
begin
  CheckFalse(TSQLJoinOrNot.New.IsReplaceable);
end;

procedure TSQLFilterJoinOrNotTest.OrNotParse;
begin
  CheckEquals('OR NOT', TSQLJoinOrNot.New.Parse(TSQLFilterSimpleFormatter.New));
end;

initialization

RegisterTest(TSQLFilterJoinOrNotTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
