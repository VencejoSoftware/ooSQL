{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit SQLConditionList_test;

interface

uses
  SysUtils,
  SQLField,
  IntegerSQLParameterValue, StringSQLParameterValue, DateSQLParameterValue,
  SQLParameter, StaticSQLParameter,
  OrSQLJoin, AndSQLJoin, NoneSQLJoin,
  SQLCondition, SingleSQLCondition, JoinedSQLCondition, EqualSQLCondition, LikeSQLCondition, NotEqualSQLCondition,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TSQLConditionListTest = class sealed(TTestCase)
  published
    procedure EmptyItemsReturnSyntaxEnclosed;
    procedure ThreeItemsReturnSyntaxOfEach;
    procedure EmptyItemsReturnIsValidFalse;
    procedure ThreeItemsReturnIsValidTrue;
  end;

implementation

procedure TSQLConditionListTest.EmptyItemsReturnSyntaxEnclosed;
var
  ConditionList: ISQLConditionList;
begin
  ConditionList := TSQLConditionList.New;
  CheckEquals(EmptyStr, ConditionList.Syntax);
end;

procedure TSQLConditionListTest.ThreeItemsReturnSyntaxOfEach;
var
  ConditionList: ISQLConditionList;
  Parameter1, Parameter2, Parameter3: ISQLParameter;
begin
  ConditionList := TSQLConditionList.New;
  Parameter1 := TStaticSQLParameter.NewWithOutName(TIntegerSQLParameterValue.New(22));
  ConditionList.Add(TJoinedSQLCondition.New(TNoneSQLJoin.New, TEqualSQLCondition.New(TSQLField.New('Field1'),
    Parameter1)));
  Parameter2 := TStaticSQLParameter.NewWithOutName(TStringSQLParameterValue.New('test'));
  ConditionList.Add(TJoinedSQLCondition.New(TAndSQLJoin.New, TLikeSQLCondition.New(TSQLField.New('Field2'),
    Parameter2)));
  Parameter3 := TStaticSQLParameter.NewWithOutName(TDateSQLParameterValue.New(EncodeDate(2010, 11, 12), 'mm-dd-yyyy'));
  ConditionList.Add(TJoinedSQLCondition.New(TOrSQLJoin.New, TNotEqualSQLCondition.New(TSQLField.New('Field3'),
    Parameter3)));
  CheckEquals('((Field1=22) AND (Field2 LIKE ''test'') OR (Field3<>''11-12-2010''))', ConditionList.Syntax);
end;

procedure TSQLConditionListTest.EmptyItemsReturnIsValidFalse;
var
  ConditionList: ISQLConditionList;
begin
  ConditionList := TSQLConditionList.New;
  CheckFalse(ConditionList.IsValid);
end;

procedure TSQLConditionListTest.ThreeItemsReturnIsValidTrue;
var
  ConditionList: ISQLConditionList;
  Parameter1, Parameter2, Parameter3: ISQLParameter;
begin
  ConditionList := TSQLConditionList.New;
  Parameter1 := TStaticSQLParameter.NewWithOutName(TIntegerSQLParameterValue.New(22));
  ConditionList.Add(TJoinedSQLCondition.New(TNoneSQLJoin.New, TEqualSQLCondition.New(TSQLField.New('Field1'),
    Parameter1)));
  Parameter2 := TStaticSQLParameter.NewWithOutName(TStringSQLParameterValue.New('test'));
  ConditionList.Add(TJoinedSQLCondition.New(TAndSQLJoin.New, TLikeSQLCondition.New(TSQLField.New('Field2'),
    Parameter2)));
  Parameter3 := TStaticSQLParameter.NewWithOutName(TDateSQLParameterValue.New(EncodeDate(2010, 11, 12), 'mm-dd-yyyy'));
  ConditionList.Add(TJoinedSQLCondition.New(TOrSQLJoin.New, TNotEqualSQLCondition.New(TSQLField.New('Field3'),
    Parameter3)));
  CheckTrue(ConditionList.IsValid);
end;

initialization

RegisterTest('Filter condition', TSQLConditionListTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
