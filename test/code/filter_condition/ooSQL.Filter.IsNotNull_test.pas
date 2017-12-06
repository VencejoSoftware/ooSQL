{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQL.Filter.IsNotNull_test;

interface

uses
  SysUtils,
  ooSQL.Filter.SimpleFormatter,
  ooSQL.Filter.IsNotNull,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TSQLConditionIsNotNullTest = class(TTestCase)
  published
    procedure FieldTestIsNotNull;
    procedure FieldTestIsEmpty;
    procedure FieldTestIsReplaceable;
    procedure FieldTestIsValid;
  end;

implementation

procedure TSQLConditionIsNotNullTest.FieldTestIsNotNull;
begin
  CheckEquals('FieldTest IS NOT NULL', TSQLConditionIsNotNull.New('FieldTest').Parse(TSQLFilterSimpleFormatter.New));
end;

procedure TSQLConditionIsNotNullTest.FieldTestIsEmpty;
begin
  CheckFalse(TSQLConditionIsNotNull.New('FieldTest').IsEmpty);
end;

procedure TSQLConditionIsNotNullTest.FieldTestIsReplaceable;
begin
  CheckFalse(TSQLConditionIsNotNull.New('FieldTest').IsReplaceable);
end;

procedure TSQLConditionIsNotNullTest.FieldTestIsValid;
begin
  CheckTrue(TSQLConditionIsNotNull.New('FieldTest').IsValid);
end;

initialization

RegisterTest(TSQLConditionIsNotNullTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
