{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit IsNotNullSQLCondition_test;

interface

uses
  SysUtils,
  SQLField,
  SQLCondition,
  IsNotNullSQLCondition,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TIsNotNullSQLConditionTest = class sealed(TTestCase)
  published
    procedure FieldIsFieldTest;
    procedure SyntaxIsFieldTestIsNotNull;
    procedure IsValidIsTrue;
  end;

implementation

procedure TIsNotNullSQLConditionTest.FieldIsFieldTest;
var
  Condition: ISQLCondition;
begin
  Condition := TIsNotNullSQLCondition.New(TSQLField.New('FieldTest'));
  CheckEquals('FieldTest', Condition.Field.Name);
end;

procedure TIsNotNullSQLConditionTest.SyntaxIsFieldTestIsNotNull;
var
  Condition: ISQLCondition;
begin
  Condition := TIsNotNullSQLCondition.New(TSQLField.New('FieldTest'));
  CheckEquals('FieldTest IS NOT NULL', Condition.Syntax);
end;

procedure TIsNotNullSQLConditionTest.IsValidIsTrue;
var
  Condition: ISQLCondition;
begin
  Condition := TIsNotNullSQLCondition.New(TSQLField.New('FieldTest'));
  CheckTrue(Condition.IsValid);
end;

initialization

RegisterTest('Filter condition', TIsNotNullSQLConditionTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
