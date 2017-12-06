{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQL.Filter.GreaterOrEqual_test;

interface

uses
  SysUtils,
  ooSQL.Filter.SimpleFormatter,
  ooSQL.Filter.GreaterOrEqual,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TSQLConditionGreaterOrEqualTest = class(TTestCase)
  published
    procedure FieldTestGreaterOrEqual200;
    procedure FieldTestIsEmpty;
    procedure FieldTestIsReplaceable;
    procedure FieldTestIsValid;
  end;

implementation

procedure TSQLConditionGreaterOrEqualTest.FieldTestGreaterOrEqual200;
begin
  CheckEquals('FieldTest >= 200',
    TSQLConditionGreaterOrEqual.New('FieldTest', '200').Parse(TSQLFilterSimpleFormatter.New));
end;

procedure TSQLConditionGreaterOrEqualTest.FieldTestIsEmpty;
begin
  CheckTrue(TSQLConditionGreaterOrEqual.New('FieldTest', EmptyStr).IsEmpty);
end;

procedure TSQLConditionGreaterOrEqualTest.FieldTestIsReplaceable;
begin
  CheckFalse(TSQLConditionGreaterOrEqual.New('FieldTest', EmptyStr).IsReplaceable);
  CheckTrue(TSQLConditionGreaterOrEqual.New('FieldTest', ':VALUE1').IsReplaceable);
end;

procedure TSQLConditionGreaterOrEqualTest.FieldTestIsValid;
begin
  CheckFalse(TSQLConditionGreaterOrEqual.New('FieldTest', EmptyStr).IsValid);
  CheckFalse(TSQLConditionGreaterOrEqual.New(EmptyStr, '200').IsValid);
end;

initialization

RegisterTest(TSQLConditionGreaterOrEqualTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
