{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQL.Filter.JoinOr_test;

interface

uses
  SysUtils,
  ooSQL.Filter.SimpleFormatter,
  ooSQL.Filter.JoinOr,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TSQLFilterJoinOrTest = class(TTestCase)
  published
    procedure OrParse;
    procedure OrIsEmpty;
    procedure OrIsReplaceable;
  end;

implementation

procedure TSQLFilterJoinOrTest.OrIsEmpty;
begin
  CheckFalse(TSQLJoinOr.New.IsEmpty);
end;

procedure TSQLFilterJoinOrTest.OrIsReplaceable;
begin
  CheckFalse(TSQLJoinOr.New.IsReplaceable);
end;

procedure TSQLFilterJoinOrTest.OrParse;
begin
  CheckEquals('OR', TSQLJoinOr.New.Parse(TSQLFilterSimpleFormatter.New));
end;

initialization

RegisterTest(TSQLFilterJoinOrTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
