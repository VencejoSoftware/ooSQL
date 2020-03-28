{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit BetweenSQLCondition_test;

interface

uses
  SysUtils,
  SQLField,
  IntegerSQLParameterValue,
  SQLParameter, StaticSQLParameter,
  SQLCondition,
  BetweenSQLCondition,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TBetweenSQLConditionTest = class sealed(TTestCase)
  published
    procedure FieldIsFieldTest;
    procedure SyntaxIsFieldTestBetween200And300;
    procedure NilValueReturnIsValidFalse;
    procedure ValueNilReturnIsValidFalse;
    procedure BothNilReturnIsValidFalse;
    procedure NullValueReturnIsValidFalse;
    procedure ValueNullReturnIsValidFalse;
  end;

implementation

procedure TBetweenSQLConditionTest.FieldIsFieldTest;
var
  Condition: ISQLCondition;
  Param1: ISQLParameter;
  Param2: ISQLParameter;
begin
  Param1 := TStaticSQLParameter.New('Param1', TIntegerSQLParameterValue.New(200));
  Param2 := TStaticSQLParameter.New('Param2', TIntegerSQLParameterValue.New(300));
  Condition := TBetweenSQLCondition.New(TSQLField.New('FieldTest'), Param1, Param2);
  CheckEquals('FieldTest', Condition.Field.Name);
end;

procedure TBetweenSQLConditionTest.SyntaxIsFieldTestBetween200And300;
var
  Condition: ISQLCondition;
  Param1: ISQLParameter;
  Param2: ISQLParameter;
begin
  Param1 := TStaticSQLParameter.New('Param1', TIntegerSQLParameterValue.New(200));
  Param2 := TStaticSQLParameter.New('Param2', TIntegerSQLParameterValue.New(300));
  Condition := TBetweenSQLCondition.New(TSQLField.New('FieldTest'), Param1, Param2);
  CheckEquals('FieldTest BETWEEN 200 AND 300', Condition.Syntax);
end;

procedure TBetweenSQLConditionTest.NilValueReturnIsValidFalse;
var
  Condition: ISQLCondition;
  Param2: ISQLParameter;
begin
  Param2 := TStaticSQLParameter.New('Param2', TIntegerSQLParameterValue.New(300));
  Condition := TBetweenSQLCondition.New(TSQLField.New('FieldTest'), nil, Param2);
  CheckFalse(Condition.IsValid);
end;

procedure TBetweenSQLConditionTest.ValueNilReturnIsValidFalse;
var
  Condition: ISQLCondition;
  Param1: ISQLParameter;
begin
  Param1 := TStaticSQLParameter.New('Param1', TIntegerSQLParameterValue.New(200));
  Condition := TBetweenSQLCondition.New(TSQLField.New('FieldTest'), Param1, nil);
  CheckFalse(Condition.IsValid);
end;

procedure TBetweenSQLConditionTest.BothNilReturnIsValidFalse;
var
  Condition: ISQLCondition;
begin
  Condition := TBetweenSQLCondition.New(TSQLField.New('FieldTest'), nil, nil);
  CheckFalse(Condition.IsValid);
end;

procedure TBetweenSQLConditionTest.NullValueReturnIsValidFalse;
var
  Condition: ISQLCondition;
  Param1: ISQLParameter;
  Param2: ISQLParameter;
begin
  Param1 := TStaticSQLParameter.New('Param1');
  Param2 := TStaticSQLParameter.New('Param2', TIntegerSQLParameterValue.New(300));
  Condition := TBetweenSQLCondition.New(TSQLField.New('FieldTest'), Param1, Param2);
  CheckFalse(Condition.IsValid);
end;

procedure TBetweenSQLConditionTest.ValueNullReturnIsValidFalse;
var
  Condition: ISQLCondition;
  Param1: ISQLParameter;
  Param2: ISQLParameter;
begin
  Param1 := TStaticSQLParameter.New('Param1', TIntegerSQLParameterValue.New(200));
  Param2 := TStaticSQLParameter.New('Param2');
  Condition := TBetweenSQLCondition.New(TSQLField.New('FieldTest'), Param1, Param2);
  CheckFalse(Condition.IsValid);
end;

initialization

RegisterTest('Filter condition', TBetweenSQLConditionTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
