{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQL.Filter.IsNull_test;

interface

uses
  SysUtils,
  ooSQL.Filter.SimpleFormatter,
  ooSQL.Filter.IsNull,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TSQLConditionIsNullTest = class(TTestCase)
  published
    procedure FieldTestIsNull;
    procedure FieldTestIsEmpty;
    procedure FieldTestIsReplaceable;
    procedure FieldTestIsValid;
  end;

implementation

procedure TSQLConditionIsNullTest.FieldTestIsNull;
begin
  CheckEquals('FieldTest IS NULL', TSQLConditionIsNull.New('FieldTest').Parse(TSQLFilterSimpleFormatter.New));
end;

procedure TSQLConditionIsNullTest.FieldTestIsEmpty;
begin
  CheckFalse(TSQLConditionIsNull.New('FieldTest').IsEmpty);
end;

procedure TSQLConditionIsNullTest.FieldTestIsReplaceable;
begin
  CheckFalse(TSQLConditionIsNull.New('FieldTest').IsReplaceable);
end;

procedure TSQLConditionIsNullTest.FieldTestIsValid;
begin
  CheckTrue(TSQLConditionIsNull.New('FieldTest').IsValid);
end;

initialization

RegisterTest(TSQLConditionIsNullTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
