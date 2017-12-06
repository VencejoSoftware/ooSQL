{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQL.Filter.Equal_test;

interface

uses
  SysUtils,
  ooSQL.Filter.SimpleFormatter,
  ooSQL.Filter.Equal,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TSQLConditionEqualTest = class(TTestCase)
  published
    procedure FieldTestEqual200;
    procedure FieldTestIsEmpty;
    procedure FieldTestIsReplaceable;
    procedure FieldTestIsValid;
  end;

implementation

procedure TSQLConditionEqualTest.FieldTestEqual200;
begin
  CheckEquals('FieldTest = 200', TSQLConditionEqual.New('FieldTest', '200').Parse(TSQLFilterSimpleFormatter.New));
end;

procedure TSQLConditionEqualTest.FieldTestIsEmpty;
begin
  CheckTrue(TSQLConditionEqual.New('FieldTest', EmptyStr).IsEmpty);
end;

procedure TSQLConditionEqualTest.FieldTestIsReplaceable;
begin
  CheckFalse(TSQLConditionEqual.New('FieldTest', EmptyStr).IsReplaceable);
  CheckTrue(TSQLConditionEqual.New('FieldTest', ':VALUE1').IsReplaceable);
end;

procedure TSQLConditionEqualTest.FieldTestIsValid;
begin
  CheckFalse(TSQLConditionEqual.New('FieldTest', EmptyStr).IsValid);
  CheckFalse(TSQLConditionEqual.New(EmptyStr, '200').IsValid);
end;

initialization

RegisterTest(TSQLConditionEqualTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
