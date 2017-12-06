{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQL.Filter.Greater_test;

interface

uses
  SysUtils,
  ooSQL.Filter.SimpleFormatter,
  ooSQL.Filter.Greater,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TSQLConditionGreaterTest = class(TTestCase)
  published
    procedure FieldTestGreater200;
    procedure FieldTestIsEmpty;
    procedure FieldTestIsReplaceable;
    procedure FieldTestIsValid;
  end;

implementation

procedure TSQLConditionGreaterTest.FieldTestGreater200;
begin
  CheckEquals('FieldTest > 200', TSQLConditionGreater.New('FieldTest', '200').Parse(TSQLFilterSimpleFormatter.New));
end;

procedure TSQLConditionGreaterTest.FieldTestIsEmpty;
begin
  CheckTrue(TSQLConditionGreater.New('FieldTest', EmptyStr).IsEmpty);
end;

procedure TSQLConditionGreaterTest.FieldTestIsReplaceable;
begin
  CheckFalse(TSQLConditionGreater.New('FieldTest', EmptyStr).IsReplaceable);
  CheckTrue(TSQLConditionGreater.New('FieldTest', ':VALUE1').IsReplaceable);
end;

procedure TSQLConditionGreaterTest.FieldTestIsValid;
begin
  CheckFalse(TSQLConditionGreater.New('FieldTest', EmptyStr).IsValid);
  CheckFalse(TSQLConditionGreater.New(EmptyStr, '200').IsValid);
end;

initialization

RegisterTest(TSQLConditionGreaterTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
