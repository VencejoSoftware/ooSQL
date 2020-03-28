{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit GreaterSQLCondition_test;

interface

uses
  SysUtils,
  SQLField,
  IntegerSQLParameterValue,
  SQLParameter, StaticSQLParameter,
  SQLCondition, SingleSQLCondition,
  GreaterSQLCondition,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TGreaterSQLConditionTest = class sealed(TTestCase)
  published
    procedure FieldIsFieldTest;
    procedure SyntaxIsFieldTestGreater200;
    procedure IsValidIsTrue;
    procedure EmptyValueReturnIsValidFalse;
    procedure EmptyParamReturnIsValidFalse;
    procedure ParameterContentIs200;
  end;

implementation

procedure TGreaterSQLConditionTest.FieldIsFieldTest;
var
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  Parameter := TStaticSQLParameter.New('Param1', TIntegerSQLParameterValue.New(200));
  Condition := TGreaterSQLCondition.New(TSQLField.New('FieldTest'), Parameter);
  CheckEquals('FieldTest', Condition.Field.Name);
end;

procedure TGreaterSQLConditionTest.SyntaxIsFieldTestGreater200;
var
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  Parameter := TStaticSQLParameter.New('Param1', TIntegerSQLParameterValue.New(200));
  Condition := TGreaterSQLCondition.New(TSQLField.New('FieldTest'), Parameter);
  CheckEquals('FieldTest>200', Condition.Syntax);
end;

procedure TGreaterSQLConditionTest.IsValidIsTrue;
var
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  Parameter := TStaticSQLParameter.New('Param1', TIntegerSQLParameterValue.New(200));
  Condition := TGreaterSQLCondition.New(TSQLField.New('FieldTest'), Parameter);
  CheckTrue(Condition.IsValid);
end;

procedure TGreaterSQLConditionTest.EmptyValueReturnIsValidFalse;
var
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  Parameter := TStaticSQLParameter.New('Param1');
  Condition := TGreaterSQLCondition.New(TSQLField.New('FieldTest'), Parameter);
  CheckFalse(Condition.IsValid);
end;

procedure TGreaterSQLConditionTest.EmptyParamReturnIsValidFalse;
var
  Condition: ISQLCondition;
begin
  Condition := TGreaterSQLCondition.New(TSQLField.New('FieldTest'), nil);
  CheckFalse(Condition.IsValid);
end;

procedure TGreaterSQLConditionTest.ParameterContentIs200;
var
  Parameter: ISQLParameter;
  Condition: ISingleSQLCondition;
begin
  Parameter := TStaticSQLParameter.New('Param1', TIntegerSQLParameterValue.New(200));
  Condition := TGreaterSQLCondition.New(TSQLField.New('FieldTest'), Parameter);
  CheckEquals('200', Condition.Parameter.Value.Content);
end;

initialization

RegisterTest('Filter condition', TGreaterSQLConditionTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
