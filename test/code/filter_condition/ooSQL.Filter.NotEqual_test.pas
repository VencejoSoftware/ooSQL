{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQL.Filter.NotEqual_test;

interface

uses
  SysUtils,
  ooSQL.Filter.SimpleFormatter,
  ooSQL.Filter.NotEqual,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TSQLConditionNotEqualTest = class(TTestCase)
  published
    procedure FieldTestNotEqual200;
    procedure FieldTestIsEmpty;
    procedure FieldTestIsReplaceable;
    procedure FieldTestIsValid;
  end;

implementation

procedure TSQLConditionNotEqualTest.FieldTestNotEqual200;
begin
  CheckEquals('FieldTest <> 200', TSQLConditionNotEqual.New('FieldTest', '200').Parse(TSQLFilterSimpleFormatter.New));
end;

procedure TSQLConditionNotEqualTest.FieldTestIsEmpty;
begin
  CheckTrue(TSQLConditionNotEqual.New('FieldTest', EmptyStr).IsEmpty);
end;

procedure TSQLConditionNotEqualTest.FieldTestIsReplaceable;
begin
  CheckFalse(TSQLConditionNotEqual.New('FieldTest', EmptyStr).IsReplaceable);
  CheckTrue(TSQLConditionNotEqual.New('FieldTest', ':VALUE1').IsReplaceable);
end;

procedure TSQLConditionNotEqualTest.FieldTestIsValid;
begin
  CheckFalse(TSQLConditionNotEqual.New('FieldTest', EmptyStr).IsValid);
  CheckFalse(TSQLConditionNotEqual.New(EmptyStr, '200').IsValid);
end;

initialization

RegisterTest(TSQLConditionNotEqualTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
