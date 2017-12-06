{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQL.Filter.JoinAndNot_test;

interface

uses
  SysUtils,
  ooSQL.Filter.SimpleFormatter,
  ooSQL.Filter.JoinAndNot,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TSQLFilterJoinAndNotTest = class(TTestCase)
  published
    procedure AndNotParse;
    procedure AndNotIsEmpty;
    procedure AndNotIsReplaceable;
  end;

implementation

procedure TSQLFilterJoinAndNotTest.AndNotIsEmpty;
begin
  CheckFalse(TSQLJoinAndNot.New.IsEmpty);
end;

procedure TSQLFilterJoinAndNotTest.AndNotIsReplaceable;
begin
  CheckFalse(TSQLJoinAndNot.New.IsReplaceable);
end;

procedure TSQLFilterJoinAndNotTest.AndNotParse;
begin
  CheckEquals('AND NOT', TSQLJoinAndNot.New.Parse(TSQLFilterSimpleFormatter.New));
end;

initialization

RegisterTest(TSQLFilterJoinAndNotTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
