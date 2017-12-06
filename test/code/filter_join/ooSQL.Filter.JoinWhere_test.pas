{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQL.Filter.JoinWhere_test;

interface

uses
  SysUtils,
  ooSQL.Filter.SimpleFormatter,
  ooSQL.Filter.JoinWhere,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TSQLFilterJoinWhereTest = class(TTestCase)
  published
    procedure WhereNotParse;
    procedure WhereNotIsEmpty;
    procedure WhereNotIsReplaceable;
  end;

implementation

procedure TSQLFilterJoinWhereTest.WhereNotIsEmpty;
begin
  CheckFalse(TSQLJoinWhere.New.IsEmpty);
end;

procedure TSQLFilterJoinWhereTest.WhereNotIsReplaceable;
begin
  CheckFalse(TSQLJoinWhere.New.IsReplaceable);
end;

procedure TSQLFilterJoinWhereTest.WhereNotParse;
begin
  CheckEquals('WHERE', TSQLJoinWhere.New.Parse(TSQLFilterSimpleFormatter.New));
end;

initialization

RegisterTest(TSQLFilterJoinWhereTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
