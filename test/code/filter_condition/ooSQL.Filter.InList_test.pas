{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQL.Filter.InList_test;

interface

uses
  SysUtils,
  ooSQL.Filter.SimpleFormatter,
  ooSQL.Filter.InList,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TSQLConditionInListTest = class(TTestCase)
  published
    procedure FieldTestInList1234;
    procedure FieldTestInListReplaceable;
    procedure FieldTestIsEmpty;
    procedure FieldTestIsReplaceable;
    procedure FieldTestIsValid;
  end;

implementation

procedure TSQLConditionInListTest.FieldTestInList1234;
begin
  CheckEquals('FieldTest IN (1, 2, 3, 4)', TSQLConditionIn.New('FieldTest', ['1', '2', '3', '4']).Parse
      (TSQLFilterSimpleFormatter.New));
end;

procedure TSQLConditionInListTest.FieldTestInListReplaceable;
begin
  CheckEquals('FieldTest IN (:VALUE1)',
    TSQLConditionIn.New('FieldTest', [':VALUE1']).Parse(TSQLFilterSimpleFormatter.New));
end;

procedure TSQLConditionInListTest.FieldTestIsEmpty;
begin
  CheckTrue(TSQLConditionIn.New('FieldTest', []).IsEmpty);
end;

procedure TSQLConditionInListTest.FieldTestIsReplaceable;
begin
  CheckFalse(TSQLConditionIn.New('FieldTest', []).IsReplaceable);
  CheckTrue(TSQLConditionIn.New('FieldTest', [':VALUE1']).IsReplaceable);
end;

procedure TSQLConditionInListTest.FieldTestIsValid;
begin
  CheckFalse(TSQLConditionIn.New('FieldTest', []).IsValid);
  CheckFalse(TSQLConditionIn.New(EmptyStr, ['1', '2']).IsValid);
end;

initialization

RegisterTest(TSQLConditionInListTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
