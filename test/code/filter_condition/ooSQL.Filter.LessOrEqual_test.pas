{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQL.Filter.LessOrEqual_test;

interface

uses
  SysUtils,
  ooSQL.Filter.SimpleFormatter,
  ooSQL.Filter.LessOrEqual,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TSQLConditionLessOrEqualTest = class(TTestCase)
  published
    procedure FieldTestLessOrEqual200;
    procedure FieldTestIsEmpty;
    procedure FieldTestIsReplaceable;
    procedure FieldTestIsValid;
  end;

implementation

procedure TSQLConditionLessOrEqualTest.FieldTestLessOrEqual200;
begin
  CheckEquals('FieldTest <= 200', TSQLConditionLessOrEqual.New('FieldTest', '200').Parse(TSQLFilterSimpleFormatter.New)
    );
end;

procedure TSQLConditionLessOrEqualTest.FieldTestIsEmpty;
begin
  CheckTrue(TSQLConditionLessOrEqual.New('FieldTest', EmptyStr).IsEmpty);
end;

procedure TSQLConditionLessOrEqualTest.FieldTestIsReplaceable;
begin
  CheckFalse(TSQLConditionLessOrEqual.New('FieldTest', EmptyStr).IsReplaceable);
  CheckTrue(TSQLConditionLessOrEqual.New('FieldTest', ':VALUE1').IsReplaceable);
end;

procedure TSQLConditionLessOrEqualTest.FieldTestIsValid;
begin
  CheckFalse(TSQLConditionLessOrEqual.New('FieldTest', EmptyStr).IsValid);
  CheckFalse(TSQLConditionLessOrEqual.New(EmptyStr, '200').IsValid);
end;

initialization

RegisterTest(TSQLConditionLessOrEqualTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
