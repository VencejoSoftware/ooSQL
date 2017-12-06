{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQL.Filter.Between_test;

interface

uses
  SysUtils,
  ooSQL.Filter.SimpleFormatter,
  ooSQL.Filter.Between,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TSQLConditionBetweenTest = class(TTestCase)
  published
    procedure FieldTestBetween90and200;
    procedure FieldTestIsEmpty;
    procedure FieldTestIsReplaceable;
    procedure FieldTestIsValid;
  end;

implementation

procedure TSQLConditionBetweenTest.FieldTestBetween90and200;
begin
  CheckEquals('FieldTest BETWEEN 90 AND 200', TSQLConditionBetween.New('FieldTest', '90',
      '200').Parse(TSQLFilterSimpleFormatter.New));
end;

procedure TSQLConditionBetweenTest.FieldTestIsEmpty;
begin
  CheckTrue(TSQLConditionBetween.New('FieldTest', '90', EmptyStr).IsEmpty);
  CheckTrue(TSQLConditionBetween.New('FieldTest', EmptyStr, '200').IsEmpty);
end;

procedure TSQLConditionBetweenTest.FieldTestIsReplaceable;
begin
  CheckFalse(TSQLConditionBetween.New('FieldTest', EmptyStr, ':VALUE2').IsReplaceable);
  CheckTrue(TSQLConditionBetween.New('FieldTest', '90', ':VALUE2').IsReplaceable);
  CheckTrue(TSQLConditionBetween.New('FieldTest', ':VALUE1', '200').IsReplaceable);
end;

procedure TSQLConditionBetweenTest.FieldTestIsValid;
begin
  CheckFalse(TSQLConditionBetween.New('FieldTest', '90', EmptyStr).IsValid);
  CheckFalse(TSQLConditionBetween.New('FieldTest', EmptyStr, '200').IsValid);
  CheckFalse(TSQLConditionBetween.New(EmptyStr, '90', '200').IsValid);
end;

initialization

RegisterTest(TSQLConditionBetweenTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
