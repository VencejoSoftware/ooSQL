{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit IsNullSQLCondition_test;

interface

uses
  SysUtils,
  SQLField,
  SQLCondition,
  IsNullSQLCondition,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TIsNullSQLConditionTest = class sealed(TTestCase)
  published
    procedure FieldIsFieldTest;
    procedure SyntaxIsFieldTestIsNull;
    procedure IsValidIsTrue;
  end;

implementation

procedure TIsNullSQLConditionTest.FieldIsFieldTest;
var
  Condition: ISQLCondition;
begin
  Condition := TIsNullSQLCondition.New(TSQLField.New('FieldTest'));
  CheckEquals('FieldTest', Condition.Field.Name);
end;

procedure TIsNullSQLConditionTest.SyntaxIsFieldTestIsNull;
var
  Condition: ISQLCondition;
begin
  Condition := TIsNullSQLCondition.New(TSQLField.New('FieldTest'));
  CheckEquals('FieldTest IS NULL', Condition.Syntax);
end;

procedure TIsNullSQLConditionTest.IsValidIsTrue;
var
  Condition: ISQLCondition;
begin
  Condition := TIsNullSQLCondition.New(TSQLField.New('FieldTest'));
  CheckTrue(Condition.IsValid);
end;

initialization

RegisterTest('Filter condition', TIsNullSQLConditionTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
