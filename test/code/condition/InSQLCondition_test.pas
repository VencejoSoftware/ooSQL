{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit InSQLCondition_test;

interface

uses
  SysUtils,
  SQLField,
  IntegerSQLParameterValue,
  SQLParameter, StaticSQLParameter,
  SQLCondition,
  InSQLCondition,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TInSQLConditionTest = class sealed(TTestCase)
  published
    procedure FieldIsFieldTest;
    procedure SyntaxIsFieldTestIn1234;
    procedure EmptyConditionReturnSyntaxEnclosed;
    procedure EmptyConditionReturnIsValidFalse;
    procedure TwoParamsWithOneValueNilReturnIsValidFalse;
    procedure WithItemsReturnIsValidTrue;
  end;

implementation

procedure TInSQLConditionTest.FieldIsFieldTest;
var
  Condition: ISQLCondition;
begin
  Condition := TInSQLCondition.New(TSQLField.New('FieldTest'), []);
  CheckEquals('FieldTest', Condition.Field.Name);
end;

procedure TInSQLConditionTest.SyntaxIsFieldTestIn1234;
var
  Condition: ISQLCondition;
  Param1: ISQLParameter;
  Param2: ISQLParameter;
  Param3: ISQLParameter;
  Param4: ISQLParameter;
begin
  Param1 := TStaticSQLParameter.New('Param1', TIntegerSQLParameterValue.New(1));
  Param2 := TStaticSQLParameter.New('Param2', TIntegerSQLParameterValue.New(2));
  Param3 := TStaticSQLParameter.New('Param3', TIntegerSQLParameterValue.New(3));
  Param4 := TStaticSQLParameter.New('Param4', TIntegerSQLParameterValue.New(4));
  Condition := TInSQLCondition.New(TSQLField.New('FieldTest'), [Param1, Param2, Param3, Param4]);
  CheckEquals('FieldTest IN (1,2,3,4)', Condition.Syntax);
end;

procedure TInSQLConditionTest.EmptyConditionReturnSyntaxEnclosed;
var
  Condition: ISQLCondition;
begin
  Condition := TInSQLCondition.New(TSQLField.New('FieldTest'), []);
  CheckEquals('FieldTest IN ()', Condition.Syntax);
end;

procedure TInSQLConditionTest.EmptyConditionReturnIsValidFalse;
var
  Condition: ISQLCondition;
begin
  Condition := TInSQLCondition.New(TSQLField.New('FieldTest'), []);
  CheckFalse(Condition.IsValid);
end;

procedure TInSQLConditionTest.TwoParamsWithOneValueNilReturnIsValidFalse;
var
  Condition: ISQLCondition;
  Param1: ISQLParameter;
  Param2: ISQLParameter;
begin
  Param1 := TStaticSQLParameter.New('Param1', TIntegerSQLParameterValue.New(1));
  Param2 := TStaticSQLParameter.New('Param2');
  Condition := TInSQLCondition.New(TSQLField.New('FieldTest'), [Param1, Param2]);
  CheckFalse(Condition.IsValid);
end;

procedure TInSQLConditionTest.WithItemsReturnIsValidTrue;
var
  Condition: ISQLCondition;
  Param1: ISQLParameter;
  Param2: ISQLParameter;
  Param3: ISQLParameter;
  Param4: ISQLParameter;
begin
  Param1 := TStaticSQLParameter.New('Param1', TIntegerSQLParameterValue.New(1));
  Param2 := TStaticSQLParameter.New('Param2', TIntegerSQLParameterValue.New(2));
  Param3 := TStaticSQLParameter.New('Param3', TIntegerSQLParameterValue.New(3));
  Param4 := TStaticSQLParameter.New('Param4', TIntegerSQLParameterValue.New(4));
  Condition := TInSQLCondition.New(TSQLField.New('FieldTest'), [Param1, Param2, Param3, Param4]);
  CheckTrue(Condition.IsValid);
end;

initialization

RegisterTest('Filter condition', TInSQLConditionTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
