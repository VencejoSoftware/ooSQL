{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit SQLConditionList_test;

interface

uses
  SysUtils,
  Key,
  SyntaxFormat, SyntaxFormatSymbol, SymbolListMock,
  IntegerSQLParameterValue, StringSQLParameterValue, DateSQLParameterValue,
  SQLParameter,
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
  ConditionList := TSQLConditionList.New(TSyntaxFormat.New(TSymbolListMock.New));
  CheckEquals(EmptyStr, ConditionList.Syntax);
end;

procedure TSQLConditionListTest.ThreeItemsReturnSyntaxOfEach;
var
  ConditionList: ISQLConditionList;
  SyntaxFormat: ISyntaxFormat;
  Parameter1, Parameter2, Parameter3: ISQLParameter;
begin
  SyntaxFormat := TSyntaxFormat.New(TSymbolListMock.New);
  ConditionList := TSQLConditionList.New(TSyntaxFormat.New(TSymbolListMock.New));
  Parameter1 := TSQLParameter.NewWithOutName;
  Parameter1.ChangeValue(TIntegerSQLParameterValue.New(22));
  ConditionList.Add(TJoinedSQLCondition.New(TNoneSQLJoin.New, TEqualSQLCondition.New(TTextKey.New('Field1'), Parameter1,
    SyntaxFormat), SyntaxFormat));
  Parameter2 := TSQLParameter.NewWithOutName;
  Parameter2.ChangeValue(TStringSQLParameterValue.New('test'));
  ConditionList.Add(TJoinedSQLCondition.New(TAndSQLJoin.New, TLikeSQLCondition.New(TTextKey.New('Field2'), Parameter2,
    SyntaxFormat), SyntaxFormat));
  Parameter3 := TSQLParameter.NewWithOutName;
  Parameter3.ChangeValue(TDateSQLParameterValue.New(EncodeDate(2010, 11, 12), 'mm-dd-yyyy'));
  ConditionList.Add(TJoinedSQLCondition.New(TOrSQLJoin.New, TNotEqualSQLCondition.New(TTextKey.New('Field3'),
    Parameter3, SyntaxFormat), SyntaxFormat));
  CheckEquals('((Field1 = 22) AND (Field2 LIKE ''test'') OR (Field3 <> ''11-12-2010''))', ConditionList.Syntax);
end;

procedure TSQLConditionListTest.EmptyItemsReturnIsValidFalse;
var
  ConditionList: ISQLConditionList;
begin
  ConditionList := TSQLConditionList.New(TSyntaxFormat.New(TSymbolListMock.New));
  CheckFalse(ConditionList.IsValid);
end;

procedure TSQLConditionListTest.ThreeItemsReturnIsValidTrue;
var
  ConditionList: ISQLConditionList;
  SyntaxFormat: ISyntaxFormat;
  Parameter1, Parameter2, Parameter3: ISQLParameter;
begin
  SyntaxFormat := TSyntaxFormat.New(TSymbolListMock.New);
  ConditionList := TSQLConditionList.New(TSyntaxFormat.New(TSymbolListMock.New));
  Parameter1 := TSQLParameter.NewWithOutName;
  Parameter1.ChangeValue(TIntegerSQLParameterValue.New(22));
  ConditionList.Add(TJoinedSQLCondition.New(TNoneSQLJoin.New, TEqualSQLCondition.New(TTextKey.New('Field1'), Parameter1,
    SyntaxFormat), SyntaxFormat));
  Parameter2 := TSQLParameter.NewWithOutName;
  Parameter2.ChangeValue(TStringSQLParameterValue.New('test'));
  ConditionList.Add(TJoinedSQLCondition.New(TAndSQLJoin.New, TLikeSQLCondition.New(TTextKey.New('Field2'), Parameter2,
    SyntaxFormat), SyntaxFormat));
  Parameter3 := TSQLParameter.NewWithOutName;
  Parameter3.ChangeValue(TDateSQLParameterValue.New(EncodeDate(2010, 11, 12), 'mm-dd-yyyy'));
  ConditionList.Add(TJoinedSQLCondition.New(TOrSQLJoin.New, TNotEqualSQLCondition.New(TTextKey.New('Field3'),
    Parameter3, SyntaxFormat), SyntaxFormat));
  CheckTrue(ConditionList.IsValid);
end;

initialization

RegisterTest(TSQLConditionListTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
