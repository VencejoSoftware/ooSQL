{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQL.Filter.JoinAnd_test;

interface

uses
  SysUtils,
  ooSQL.Filter.SimpleFormatter,
  ooSQL.Filter.JoinAnd,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TSQLFilterJoinAndTest = class(TTestCase)
  published
    procedure AndParse;
    procedure AndIsEmpty;
    procedure AndIsReplaceable;
  end;

implementation

procedure TSQLFilterJoinAndTest.AndIsEmpty;
begin
  CheckFalse(TSQLJoinAnd.New.IsEmpty);
end;

procedure TSQLFilterJoinAndTest.AndIsReplaceable;
begin
  CheckFalse(TSQLJoinAnd.New.IsReplaceable);
end;

procedure TSQLFilterJoinAndTest.AndParse;
begin
  CheckEquals('AND', TSQLJoinAnd.New.Parse(TSQLFilterSimpleFormatter.New));
end;

initialization

RegisterTest(TSQLFilterJoinAndTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
