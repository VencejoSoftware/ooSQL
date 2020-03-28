{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit LessOrEqualSQLCondition_test;

interface

uses
  SysUtils,
  SQLField,
  IntegerSQLParameterValue,
  SQLParameter, StaticSQLParameter,
  SQLCondition, SingleSQLCondition,
  LessOrEqualSQLCondition,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TLessOrEqualSQLConditionTest = class sealed(TTestCase)
  published
    procedure FieldIsFieldTest;
    procedure SyntaxIsFieldTestLessOrEqual200;
    procedure IsValidIsTrue;
    procedure EmptyValueReturnIsValidFalse;
    procedure EmptyParamReturnIsValidFalse;
    procedure ParameterContentIs200;
  end;

implementation

procedure TLessOrEqualSQLConditionTest.FieldIsFieldTest;
var
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  Parameter := TStaticSQLParameter.New('Param1', TIntegerSQLParameterValue.New(200));
  Condition := TLessOrEqualSQLCondition.New(TSQLField.New('FieldTest'), Parameter);
  CheckEquals('FieldTest', Condition.Field.Name);
end;

procedure TLessOrEqualSQLConditionTest.SyntaxIsFieldTestLessOrEqual200;
var
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  Parameter := TStaticSQLParameter.New('Param1', TIntegerSQLParameterValue.New(200));
  Condition := TLessOrEqualSQLCondition.New(TSQLField.New('FieldTest'), Parameter);
  CheckEquals('FieldTest<=200', Condition.Syntax);
end;

procedure TLessOrEqualSQLConditionTest.IsValidIsTrue;
var
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  Parameter := TStaticSQLParameter.New('Param1', TIntegerSQLParameterValue.New(200));
  Condition := TLessOrEqualSQLCondition.New(TSQLField.New('FieldTest'), Parameter);
  CheckTrue(Condition.IsValid);
end;

procedure TLessOrEqualSQLConditionTest.EmptyValueReturnIsValidFalse;
var
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  Parameter := TStaticSQLParameter.New('Param1');
  Condition := TLessOrEqualSQLCondition.New(TSQLField.New('FieldTest'), Parameter);
  CheckFalse(Condition.IsValid);
end;

procedure TLessOrEqualSQLConditionTest.EmptyParamReturnIsValidFalse;
var
  Condition: ISQLCondition;
begin
  Condition := TLessOrEqualSQLCondition.New(TSQLField.New('FieldTest'), nil);
  CheckFalse(Condition.IsValid);
end;

procedure TLessOrEqualSQLConditionTest.ParameterContentIs200;
var
  Parameter: ISQLParameter;
  Condition: ISingleSQLCondition;
begin
  Parameter := TStaticSQLParameter.New('Param1', TIntegerSQLParameterValue.New(200));
  Condition := TLessOrEqualSQLCondition.New(TSQLField.New('FieldTest'), Parameter);
  CheckEquals('200', Condition.Parameter.Value.Content);
end;

initialization

RegisterTest('Filter condition', TLessOrEqualSQLConditionTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
