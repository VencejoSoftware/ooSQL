{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit SQLFilter_test;

interface

uses
  SysUtils,
  SQLField,
  IntegerSQLParameterValue, ReplaceableSQLParameterValue,
  SQLParameter, StaticSQLParameter, MutableSQLParameter,
  SQLFilter,
  NoneSQLJoin, OrSQLJoin, AndSQLJoin, WhereSQL,
  EqualSQLCondition, JoinedSQLCondition,
  InSQLCondition,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TSQLFilterTest = class(TTestCase)
  published
    procedure KeyIsAlwaysNil;
    procedure JoinIsANDObject;
    procedure FilterWithoutJoin;
    procedure FilterWithTwoConditions;
    procedure FilterWithTwoConditionsAndJoin;
    procedure FilterJoinedWithFilter;
    procedure FilterWhereComplex;
    procedure EmptyConditionListReturnIsValidFalse;
    procedure FilterWithOneParameterJoinedWithAndIsText;
  end;

implementation

procedure TSQLFilterTest.KeyIsAlwaysNil;
var
  Parameter: ISQLParameter;
  Filter: ISQLFilter;
begin
  Filter := TSQLFilter.New(TNoneSQLJoin.New);
  Parameter := TStaticSQLParameter.New('Param1');
  Filter.ConditionList.Add(TEqualSQLCondition.New(TSQLField.New('Field1'), Parameter));
  CheckTrue(not Assigned(Filter.Field));
end;

procedure TSQLFilterTest.JoinIsANDObject;
var
  Parameter: ISQLParameter;
  Filter: ISQLFilter;
begin
  Filter := TSQLFilter.New(TAndSQLJoin.New);
  Parameter := TStaticSQLParameter.New('Param1', TIntegerSQLParameterValue.New(22));
  Filter.ConditionList.Add(TEqualSQLCondition.New(TSQLField.New('Field1'), Parameter));
  CheckTrue(Filter.Join is TAndSQLJoin);
end;

procedure TSQLFilterTest.FilterWithOneParameterJoinedWithAndIsText;
var
  Parameter: IMutableSQLParameter;
  Filter: ISQLFilter;
begin
  Filter := TSQLFilter.New(TAndSQLJoin.New);
  Parameter := TMutableSQLParameter.NewWithOutName;
  Parameter.ChangeValue(TReplaceableSQLParameterValue.New('VALUE'));
  Filter.ConditionList.Add(TEqualSQLCondition.New(TSQLField.New('Field1'), Parameter));
  CheckEquals('AND (Field1=:VALUE)', Filter.Syntax);
end;

procedure TSQLFilterTest.FilterWithoutJoin;
var
  Parameter: ISQLParameter;
  Filter: ISQLFilter;
begin
  Filter := TSQLFilter.New(TNoneSQLJoin.New);
  Parameter := TStaticSQLParameter.New('Param1', TIntegerSQLParameterValue.New(22));
  Filter.ConditionList.Add(TEqualSQLCondition.New(TSQLField.New('Field1'), Parameter));
  CheckEquals('(Field1=22)', Filter.Syntax);
end;

procedure TSQLFilterTest.FilterWithTwoConditions;
var
  Parameter: IMutableSQLParameter;
  Parameter1, Parameter2, Parameter3, Parameter4: ISQLParameter;
  Filter: ISQLFilter;
begin
  Filter := TSQLFilter.New(TNoneSQLJoin.New);
  Parameter := TMutableSQLParameter.NewWithOutName;
  Parameter.ChangeValue(TIntegerSQLParameterValue.New(22));
  Filter.ConditionList.Add(TEqualSQLCondition.New(TSQLField.New('Field1'), Parameter));
  Parameter1 := TStaticSQLParameter.NewWithOutName(TIntegerSQLParameterValue.New(1));
  Parameter2 := TStaticSQLParameter.NewWithOutName(TIntegerSQLParameterValue.New(5));
  Parameter3 := TStaticSQLParameter.NewWithOutName(TIntegerSQLParameterValue.New(10));
  Parameter4 := TStaticSQLParameter.NewWithOutName(TIntegerSQLParameterValue.New(15));
  Filter.ConditionList.Add(TJoinedSQLCondition.New(TOrSQLJoin.New, TInSQLCondition.New(TSQLField.New('Field1'),
    [Parameter1, Parameter2, Parameter3, Parameter4])));
  CheckEquals('(Field1=22 OR (Field1 IN (1,5,10,15)))', Filter.Syntax);
end;

procedure TSQLFilterTest.FilterWithTwoConditionsAndJoin;
var
  Parameter: IMutableSQLParameter;
  Parameter1, Parameter2, Parameter3, Parameter4: ISQLParameter;
  Filter: ISQLFilter;
begin
  Filter := TSQLFilter.New(TAndSQLJoin.New);
  Parameter := TMutableSQLParameter.NewWithOutName;
  Parameter.ChangeValue(TIntegerSQLParameterValue.New(22));
  Filter.ConditionList.Add(TEqualSQLCondition.New(TSQLField.New('Field1'), Parameter));
  Parameter1 := TStaticSQLParameter.NewWithOutName(TIntegerSQLParameterValue.New(1));
  Parameter2 := TStaticSQLParameter.NewWithOutName(TIntegerSQLParameterValue.New(5));
  Parameter3 := TStaticSQLParameter.NewWithOutName(TIntegerSQLParameterValue.New(10));
  Parameter4 := TStaticSQLParameter.NewWithOutName(TIntegerSQLParameterValue.New(15));
  Filter.ConditionList.Add(TJoinedSQLCondition.New(TOrSQLJoin.New, TInSQLCondition.New(TSQLField.New('Field1'),
    [Parameter1, Parameter2, Parameter3, Parameter4])));
  CheckEquals('AND (Field1=22 OR (Field1 IN (1,5,10,15)))', Filter.Syntax);
end;

procedure TSQLFilterTest.FilterJoinedWithFilter;
var
  ParameterA, ParameterB: IMutableSQLParameter;
  Parameter1, Parameter2, Parameter3, Parameter4: ISQLParameter;
  Filter, InnerFilter: ISQLFilter;
begin
  Filter := TSQLFilter.New(TNoneSQLJoin.New);
  ParameterA := TMutableSQLParameter.NewWithOutName;
  ParameterA.ChangeValue(TIntegerSQLParameterValue.New(22));
  Filter.ConditionList.Add(TEqualSQLCondition.New(TSQLField.New('Field1'), ParameterA));
  InnerFilter := TSQLFilter.New(TAndSQLJoin.New);
  ParameterB := TMutableSQLParameter.NewWithOutName;
  ParameterB.ChangeValue(TIntegerSQLParameterValue.New(22));
  InnerFilter.ConditionList.Add(TEqualSQLCondition.New(TSQLField.New('Field1'), ParameterB));
  Parameter1 := TStaticSQLParameter.NewWithOutName(TIntegerSQLParameterValue.New(1));
  Parameter2 := TStaticSQLParameter.NewWithOutName(TIntegerSQLParameterValue.New(5));
  Parameter3 := TStaticSQLParameter.NewWithOutName(TIntegerSQLParameterValue.New(10));
  Parameter4 := TStaticSQLParameter.NewWithOutName(TIntegerSQLParameterValue.New(15));
  InnerFilter.ConditionList.Add(TJoinedSQLCondition.New(TOrSQLJoin.New, TInSQLCondition.New(TSQLField.New('Field1'),
    [Parameter1, Parameter2, Parameter3, Parameter4])));
  Filter.ConditionList.Add(InnerFilter);
  CheckEquals('(Field1=22 AND (Field1=22 OR (Field1 IN (1,5,10,15))))', Filter.Syntax);
end;

procedure TSQLFilterTest.FilterWhereComplex;
var
  Parameter: IMutableSQLParameter;
  Parameter1, Parameter2, Parameter3, Parameter4: ISQLParameter;
  Filter, InnerFilter: ISQLFilter;
begin
  Filter := TSQLFilter.New(TWhereSQL.New);
  Parameter := TMutableSQLParameter.NewWithOutName;
  Parameter.ChangeValue(TReplaceableSQLParameterValue.New('VALUE'));
  Filter.ConditionList.Add(TJoinedSQLCondition.New(TNoneSQLJoin.New, TEqualSQLCondition.New(TSQLField.New('Field1'),
    Parameter)));
  InnerFilter := TSQLFilter.New(TAndSQLJoin.New);
  Parameter1 := TStaticSQLParameter.NewWithOutName(TIntegerSQLParameterValue.New(1));
  Parameter2 := TStaticSQLParameter.NewWithOutName(TIntegerSQLParameterValue.New(5));
  Parameter3 := TStaticSQLParameter.NewWithOutName(TIntegerSQLParameterValue.New(10));
  Parameter4 := TStaticSQLParameter.NewWithOutName(TIntegerSQLParameterValue.New(15));
  InnerFilter.ConditionList.Add(TJoinedSQLCondition.New(TNoneSQLJoin.New, TInSQLCondition.New(TSQLField.New('Field1'),
    [Parameter1, Parameter2, Parameter3, Parameter4])));
  Filter.ConditionList.Add(InnerFilter);
  CheckEquals('WHERE ((Field1=:VALUE) AND ((Field1 IN (1,5,10,15))))', Filter.Syntax);
end;

procedure TSQLFilterTest.EmptyConditionListReturnIsValidFalse;
var
  Filter: ISQLFilter;
begin
  Filter := TSQLFilter.New(TAndSQLJoin.New);
  CheckFalse(Filter.IsValid);
end;

initialization

RegisterTest('Statement', TSQLFilterTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
