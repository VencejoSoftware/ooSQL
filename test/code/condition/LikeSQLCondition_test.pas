{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit LikeSQLCondition_test;

interface

uses
  SysUtils,
  SQLField,
  IntegerSQLParameterValue,
  SQLParameter, StaticSQLParameter,
  SQLCondition, SingleSQLCondition,
  LikeSQLCondition,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TLikeSQLConditionTest = class sealed(TTestCase)
  published
    procedure FieldIsFieldTest;
    procedure SyntaxIsFieldTestLike200;
    procedure IsValidIsTrue;
    procedure EmptyValueReturnIsValidFalse;
    procedure EmptyParamReturnIsValidFalse;
    procedure ParameterContentIs200;
  end;

implementation

procedure TLikeSQLConditionTest.FieldIsFieldTest;
var
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  Parameter := TStaticSQLParameter.New('Param1', TIntegerSQLParameterValue.New(200));
  Condition := TLikeSQLCondition.New(TSQLField.New('FieldTest'), Parameter);
  CheckEquals('FieldTest', Condition.Field.Name);
end;

procedure TLikeSQLConditionTest.SyntaxIsFieldTestLike200;
var
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  Parameter := TStaticSQLParameter.New('Param1', TIntegerSQLParameterValue.New(200));
  Condition := TLikeSQLCondition.New(TSQLField.New('FieldTest'), Parameter);
  CheckEquals('FieldTest LIKE 200', Condition.Syntax);
end;

procedure TLikeSQLConditionTest.IsValidIsTrue;
var
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  Parameter := TStaticSQLParameter.New('Param1', TIntegerSQLParameterValue.New(200));
  Condition := TLikeSQLCondition.New(TSQLField.New('FieldTest'), Parameter);
  CheckTrue(Condition.IsValid);
end;

procedure TLikeSQLConditionTest.EmptyValueReturnIsValidFalse;
var
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  Parameter := TStaticSQLParameter.New('Param1');
  Condition := TLikeSQLCondition.New(TSQLField.New('FieldTest'), Parameter);
  CheckFalse(Condition.IsValid);
end;

procedure TLikeSQLConditionTest.EmptyParamReturnIsValidFalse;
var
  Condition: ISQLCondition;
begin
  Condition := TLikeSQLCondition.New(TSQLField.New('FieldTest'), nil);
  CheckFalse(Condition.IsValid);
end;

procedure TLikeSQLConditionTest.ParameterContentIs200;
var
  Parameter: ISQLParameter;
  Condition: ISingleSQLCondition;
begin
  Parameter := TStaticSQLParameter.New('Param1', TIntegerSQLParameterValue.New(200));
  Condition := TLikeSQLCondition.New(TSQLField.New('FieldTest'), Parameter);
  CheckEquals('200', Condition.Parameter.Value.Content);
end;

initialization

RegisterTest('Filter condition', TLikeSQLConditionTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
