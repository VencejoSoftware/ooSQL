{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQL.Filter.Less_test;

interface

uses
  SysUtils,
  ooSQL.Filter.SimpleFormatter,
  ooSQL.Filter.Less,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TSQLConditionLessTest = class(TTestCase)
  published
    procedure FieldTestLess200;
    procedure FieldTestIsEmpty;
    procedure FieldTestIsReplaceable;
    procedure FieldTestIsValid;
  end;

implementation

procedure TSQLConditionLessTest.FieldTestLess200;
begin
  CheckEquals('FieldTest < 200', TSQLConditionLess.New('FieldTest', '200').Parse(TSQLFilterSimpleFormatter.New));
end;

procedure TSQLConditionLessTest.FieldTestIsEmpty;
begin
  CheckTrue(TSQLConditionLess.New('FieldTest', EmptyStr).IsEmpty);
end;

procedure TSQLConditionLessTest.FieldTestIsReplaceable;
begin
  CheckFalse(TSQLConditionLess.New('FieldTest', EmptyStr).IsReplaceable);
  CheckTrue(TSQLConditionLess.New('FieldTest', ':VALUE1').IsReplaceable);
end;

procedure TSQLConditionLessTest.FieldTestIsValid;
begin
  CheckFalse(TSQLConditionLess.New('FieldTest', EmptyStr).IsValid);
  CheckFalse(TSQLConditionLess.New(EmptyStr, '200').IsValid);
end;

initialization

RegisterTest(TSQLConditionLessTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
