{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit LessSQLCondition_test;

interface

uses
  SysUtils,
  SQLField,
  IntegerSQLParameterValue,
  SQLParameter, StaticSQLParameter,
  SQLCondition, SingleSQLCondition,
  LessSQLCondition,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TLessSQLConditionTest = class sealed(TTestCase)
  published
    procedure FieldIsFieldTest;
    procedure SyntaxIsFieldTestLess200;
    procedure IsValidIsTrue;
    procedure EmptyValueReturnIsValidFalse;
    procedure EmptyParamReturnIsValidFalse;
    procedure ParameterContentIs200;
  end;

implementation

procedure TLessSQLConditionTest.FieldIsFieldTest;
var
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  Parameter := TStaticSQLParameter.New('Param1', TIntegerSQLParameterValue.New(200));
  Condition := TLessSQLCondition.New(TSQLField.New('FieldTest'), Parameter);
  CheckEquals('FieldTest', Condition.Field.Name);
end;

procedure TLessSQLConditionTest.SyntaxIsFieldTestLess200;
var
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  Parameter := TStaticSQLParameter.New('Param1', TIntegerSQLParameterValue.New(200));
  Condition := TLessSQLCondition.New(TSQLField.New('FieldTest'), Parameter);
  CheckEquals('FieldTest<200', Condition.Syntax);
end;

procedure TLessSQLConditionTest.IsValidIsTrue;
var
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  Parameter := TStaticSQLParameter.New('Param1', TIntegerSQLParameterValue.New(200));
  Condition := TLessSQLCondition.New(TSQLField.New('FieldTest'), Parameter);
  CheckTrue(Condition.IsValid);
end;

procedure TLessSQLConditionTest.EmptyValueReturnIsValidFalse;
var
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  Parameter := TStaticSQLParameter.New('Param1');
  Condition := TLessSQLCondition.New(TSQLField.New('FieldTest'), Parameter);
  CheckFalse(Condition.IsValid);
end;

procedure TLessSQLConditionTest.EmptyParamReturnIsValidFalse;
var
  Condition: ISQLCondition;
begin
  Condition := TLessSQLCondition.New(TSQLField.New('FieldTest'), nil);
  CheckFalse(Condition.IsValid);
end;

procedure TLessSQLConditionTest.ParameterContentIs200;
var
  Parameter: ISQLParameter;
  Condition: ISingleSQLCondition;
begin
  Parameter := TStaticSQLParameter.New('Param1', TIntegerSQLParameterValue.New(200));
  Condition := TLessSQLCondition.New(TSQLField.New('FieldTest'), Parameter);
  CheckEquals('200', Condition.Parameter.Value.Content);
end;

initialization

RegisterTest('Filter condition', TLessSQLConditionTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
