{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit SQLFilter_test;

interface

uses
  SysUtils,
  Key,
  SyntaxFormat, SyntaxFormatSymbol, SymbolListMock,
  IntegerSQLParameterValue, DynamicSQLParameterValue,
  SQLParameter,
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
  strict private
    _SyntaxFormat: ISyntaxFormat;
  public
    procedure SetUp; override;
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
  Filter := TSQLFilter.New(TNoneSQLJoin.New, _SyntaxFormat);
  Parameter := TSQLParameter.New('Param1');
  Filter.ConditionList.Add(TEqualSQLCondition.New(TTextKey.New('Field1'), Parameter, _SyntaxFormat));
  CheckTrue(not Assigned(Filter.Key));
end;

procedure TSQLFilterTest.JoinIsANDObject;
var
  Parameter: ISQLParameter;
  Filter: ISQLFilter;
begin
  Filter := TSQLFilter.New(TAndSQLJoin.New, _SyntaxFormat);
  Parameter := TSQLParameter.New('Param1');
  Parameter.ChangeValue(TIntegerSQLParameterValue.New(22));
  Filter.ConditionList.Add(TEqualSQLCondition.New(TTextKey.New('Field1'), Parameter, _SyntaxFormat));
  CheckTrue(Filter.Join is TAndSQLJoin);
end;

procedure TSQLFilterTest.FilterWithOneParameterJoinedWithAndIsText;
var
  Parameter: ISQLParameter;
  Filter: ISQLFilter;
begin
  Filter := TSQLFilter.New(TAndSQLJoin.New, _SyntaxFormat);
  Parameter := TSQLParameter.NewWithOutName;
  Parameter.ChangeValue(TDynamicSQLParameterValue.New('VALUE'));
  Filter.ConditionList.Add(TEqualSQLCondition.New(TTextKey.New('Field1'), Parameter, _SyntaxFormat));
  CheckEquals('AND (Field1 = :VALUE)', Filter.Syntax);
end;

procedure TSQLFilterTest.FilterWithoutJoin;
var
  Parameter: ISQLParameter;
  Filter: ISQLFilter;
begin
  Filter := TSQLFilter.New(TNoneSQLJoin.New, _SyntaxFormat);
  Parameter := TSQLParameter.New('Param1');
  Parameter.ChangeValue(TIntegerSQLParameterValue.New(22));
  Filter.ConditionList.Add(TEqualSQLCondition.New(TTextKey.New('Field1'), Parameter, _SyntaxFormat));
  CheckEquals('(Field1 = 22)', Filter.Syntax);
end;

procedure TSQLFilterTest.FilterWithTwoConditions;
var
  Parameter: ISQLParameter;
  Parameter1, Parameter2, Parameter3, Parameter4: ISQLParameter;
  Filter: ISQLFilter;
begin
  Filter := TSQLFilter.New(TNoneSQLJoin.New, _SyntaxFormat);
  Parameter := TSQLParameter.NewWithOutName;
  Parameter.ChangeValue(TIntegerSQLParameterValue.New(22));
  Filter.ConditionList.Add(TEqualSQLCondition.New(TTextKey.New('Field1'), Parameter, _SyntaxFormat));
  Parameter1 := TSQLParameter.NewWithOutName;
  Parameter1.ChangeValue(TIntegerSQLParameterValue.New(1));
  Parameter2 := TSQLParameter.NewWithOutName;
  Parameter2.ChangeValue(TIntegerSQLParameterValue.New(5));
  Parameter3 := TSQLParameter.NewWithOutName;
  Parameter3.ChangeValue(TIntegerSQLParameterValue.New(10));
  Parameter4 := TSQLParameter.NewWithOutName;
  Parameter4.ChangeValue(TIntegerSQLParameterValue.New(15));
  Filter.ConditionList.Add(TJoinedSQLCondition.New(TOrSQLJoin.New, TInSQLCondition.New(TTextKey.New('Field1'),
    [Parameter1, Parameter2, Parameter3, Parameter4], _SyntaxFormat), _SyntaxFormat));
  CheckEquals('(Field1 = 22 OR (Field1 IN (1, 5, 10, 15)))', Filter.Syntax);
end;

procedure TSQLFilterTest.FilterWithTwoConditionsAndJoin;
var
  Parameter: ISQLParameter;
  Parameter1, Parameter2, Parameter3, Parameter4: ISQLParameter;
  Filter: ISQLFilter;
begin
  Filter := TSQLFilter.New(TAndSQLJoin.New, _SyntaxFormat);
  Parameter := TSQLParameter.NewWithOutName;
  Parameter.ChangeValue(TIntegerSQLParameterValue.New(22));
  Filter.ConditionList.Add(TEqualSQLCondition.New(TTextKey.New('Field1'), Parameter, _SyntaxFormat));
  Parameter1 := TSQLParameter.NewWithOutName;
  Parameter1.ChangeValue(TIntegerSQLParameterValue.New(1));
  Parameter2 := TSQLParameter.NewWithOutName;
  Parameter2.ChangeValue(TIntegerSQLParameterValue.New(5));
  Parameter3 := TSQLParameter.NewWithOutName;
  Parameter3.ChangeValue(TIntegerSQLParameterValue.New(10));
  Parameter4 := TSQLParameter.NewWithOutName;
  Parameter4.ChangeValue(TIntegerSQLParameterValue.New(15));
  Filter.ConditionList.Add(TJoinedSQLCondition.New(TOrSQLJoin.New, TInSQLCondition.New(TTextKey.New('Field1'),
    [Parameter1, Parameter2, Parameter3, Parameter4], _SyntaxFormat), _SyntaxFormat));
  CheckEquals('AND (Field1 = 22 OR (Field1 IN (1, 5, 10, 15)))', Filter.Syntax);
end;

procedure TSQLFilterTest.FilterJoinedWithFilter;
var
  ParameterA, ParameterB: ISQLParameter;
  Parameter1, Parameter2, Parameter3, Parameter4: ISQLParameter;
  Filter, InnerFilter: ISQLFilter;
begin
  Filter := TSQLFilter.New(TNoneSQLJoin.New, _SyntaxFormat);
  ParameterA := TSQLParameter.NewWithOutName;
  ParameterA.ChangeValue(TIntegerSQLParameterValue.New(22));
  Filter.ConditionList.Add(TEqualSQLCondition.New(TTextKey.New('Field1'), ParameterA, _SyntaxFormat));
  InnerFilter := TSQLFilter.New(TAndSQLJoin.New, _SyntaxFormat);
  ParameterB := TSQLParameter.NewWithOutName;
  ParameterB.ChangeValue(TIntegerSQLParameterValue.New(22));
  InnerFilter.ConditionList.Add(TEqualSQLCondition.New(TTextKey.New('Field1'), ParameterB, _SyntaxFormat));
  Parameter1 := TSQLParameter.NewWithOutName;
  Parameter1.ChangeValue(TIntegerSQLParameterValue.New(1));
  Parameter2 := TSQLParameter.NewWithOutName;
  Parameter2.ChangeValue(TIntegerSQLParameterValue.New(5));
  Parameter3 := TSQLParameter.NewWithOutName;
  Parameter3.ChangeValue(TIntegerSQLParameterValue.New(10));
  Parameter4 := TSQLParameter.NewWithOutName;
  Parameter4.ChangeValue(TIntegerSQLParameterValue.New(15));
  InnerFilter.ConditionList.Add(TJoinedSQLCondition.New(TOrSQLJoin.New, TInSQLCondition.New(TTextKey.New('Field1'),
    [Parameter1, Parameter2, Parameter3, Parameter4], _SyntaxFormat), _SyntaxFormat));
  Filter.ConditionList.Add(InnerFilter);
  CheckEquals('(Field1 = 22 AND (Field1 = 22 OR (Field1 IN (1, 5, 10, 15))))', Filter.Syntax);
end;

procedure TSQLFilterTest.FilterWhereComplex;
var
  Parameter: ISQLParameter;
  Parameter1, Parameter2, Parameter3, Parameter4: ISQLParameter;
  Filter, InnerFilter: ISQLFilter;
begin
  Filter := TSQLFilter.New(TWhereSQL.New, _SyntaxFormat);
  Parameter := TSQLParameter.NewWithOutName;
  Parameter.ChangeValue(TDynamicSQLParameterValue.New('VALUE'));
  Filter.ConditionList.Add(TJoinedSQLCondition.New(TNoneSQLJoin.New, TEqualSQLCondition.New(TTextKey.New('Field1'),
    Parameter, _SyntaxFormat), _SyntaxFormat));
  InnerFilter := TSQLFilter.New(TAndSQLJoin.New, _SyntaxFormat);
  Parameter1 := TSQLParameter.NewWithOutName;
  Parameter1.ChangeValue(TIntegerSQLParameterValue.New(1));
  Parameter2 := TSQLParameter.NewWithOutName;
  Parameter2.ChangeValue(TIntegerSQLParameterValue.New(5));
  Parameter3 := TSQLParameter.NewWithOutName;
  Parameter3.ChangeValue(TIntegerSQLParameterValue.New(10));
  Parameter4 := TSQLParameter.NewWithOutName;
  Parameter4.ChangeValue(TIntegerSQLParameterValue.New(15));
  InnerFilter.ConditionList.Add(TJoinedSQLCondition.New(TNoneSQLJoin.New, TInSQLCondition.New(TTextKey.New('Field1'),
    [Parameter1, Parameter2, Parameter3, Parameter4], _SyntaxFormat), _SyntaxFormat));
  Filter.ConditionList.Add(InnerFilter);
  CheckEquals('WHERE ((Field1 = :VALUE) AND ((Field1 IN (1, 5, 10, 15))))', Filter.Syntax);
end;

procedure TSQLFilterTest.EmptyConditionListReturnIsValidFalse;
var
  Filter: ISQLFilter;
begin
  Filter := TSQLFilter.New(TAndSQLJoin.New, _SyntaxFormat);
  CheckFalse(Filter.IsValid);
end;

procedure TSQLFilterTest.SetUp;
begin
  inherited;
  _SyntaxFormat := TSyntaxFormat.New(TSymbolListMock.New);
end;

initialization

RegisterTest(TSQLFilterTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
