{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit GreaterOrEqualSQLCondition_test;

interface

uses
  SysUtils,
  SQLField,
  IntegerSQLParameterValue,
  SQLParameter, StaticSQLParameter,
  SQLCondition, SingleSQLCondition,
  GreaterOrEqualSQLCondition,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TGreaterOrEqualSQLConditionTest = class sealed(TTestCase)
  published
    procedure FieldIsFieldTest;
    procedure SyntaxIsFieldTestGreaterOrEqual200;
    procedure IsValidIsTrue;
    procedure EmptyValueReturnIsValidFalse;
    procedure EmptyParamReturnIsValidFalse;
    procedure ParameterContentIs200;
  end;

implementation

procedure TGreaterOrEqualSQLConditionTest.FieldIsFieldTest;
var
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  Parameter := TStaticSQLParameter.New('Param1', TIntegerSQLParameterValue.New(200));
  Condition := TGreaterOrEqualSQLCondition.New(TSQLField.New('FieldTest'), Parameter);
  CheckEquals('FieldTest', Condition.Field.Name);
end;

procedure TGreaterOrEqualSQLConditionTest.SyntaxIsFieldTestGreaterOrEqual200;
var
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  Parameter := TStaticSQLParameter.New('Param1', TIntegerSQLParameterValue.New(200));
  Condition := TGreaterOrEqualSQLCondition.New(TSQLField.New('FieldTest'), Parameter);
  CheckEquals('FieldTest>=200', Condition.Syntax);
end;

procedure TGreaterOrEqualSQLConditionTest.IsValidIsTrue;
var
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  Parameter := TStaticSQLParameter.New('Param1', TIntegerSQLParameterValue.New(200));
  Condition := TGreaterOrEqualSQLCondition.New(TSQLField.New('FieldTest'), Parameter);
  CheckTrue(Condition.IsValid);
end;

procedure TGreaterOrEqualSQLConditionTest.EmptyValueReturnIsValidFalse;
var
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  Parameter := TStaticSQLParameter.New('Param1');
  Condition := TGreaterOrEqualSQLCondition.New(TSQLField.New('FieldTest'), Parameter);
  CheckFalse(Condition.IsValid);
end;

procedure TGreaterOrEqualSQLConditionTest.EmptyParamReturnIsValidFalse;
var
  Condition: ISQLCondition;
begin
  Condition := TGreaterOrEqualSQLCondition.New(TSQLField.New('FieldTest'), nil);
  CheckFalse(Condition.IsValid);
end;

procedure TGreaterOrEqualSQLConditionTest.ParameterContentIs200;
var
  Parameter: ISQLParameter;
  Condition: ISingleSQLCondition;
begin
  Parameter := TStaticSQLParameter.New('Param1', TIntegerSQLParameterValue.New(200));
  Condition := TGreaterOrEqualSQLCondition.New(TSQLField.New('FieldTest'), Parameter);
  CheckEquals('200', Condition.Parameter.Value.Content);
end;

initialization

RegisterTest('Filter condition', TGreaterOrEqualSQLConditionTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
