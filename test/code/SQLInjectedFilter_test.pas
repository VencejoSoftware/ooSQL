{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit SQLInjectedFilter_test;

interface

uses
  SysUtils,
  SQLField,
  SQLFilter,
  EqualSQLCondition,
  SQLInjectedFilter,
  NoneSQLJoin, WhereSQL, AndSQLJoin,
  ReplaceableSQLParameterValue,
  SQLParameter, StaticSQLParameter, MutableSQLParameter, ReplaceableSQLParameter,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TSQLInjectedFilterTest = class sealed(TTestCase)
  published
    procedure InjectWithOutWhere;
    procedure InjectWithWhere;
    procedure InjectWithOrderBy;
    procedure InjectWithWhereAndOrderBy;
    procedure InjectWithMultipleOrderBy;
  end;

implementation

procedure TSQLInjectedFilterTest.InjectWithMultipleOrderBy;
const
  SQL = 'SELECT (SELECT 1 FROM TABLE 2 ORDER BY 2) FROM TABLE1 ORDER BY 1';
var
  Filter: ISQLFilter;
  Param1: ISQLParameter;
begin
  Filter := TSQLFilter.New(TNoneSQLJoin.New);
  Param1 := TstaticSQLParameter.NewWithOutName(TReplaceableSQLParameterValue.New('VALUE'));
  Filter.ConditionList.Add(TEqualSQLCondition.New(TSQLField.New('Field1'), Param1));
  CheckEquals('SELECT (SELECT 1 FROM TABLE 2 ORDER BY 2) FROM TABLE1 WHERE (Field1=:VALUE) ORDER BY 1',
    TSQLInjectedFilter.New.Parse(SQL, Filter));
end;

procedure TSQLInjectedFilterTest.InjectWithOrderBy;
const
  SQL = 'SELECT * FROM TABLE1 ORDER BY 1';
var
  Filter: ISQLFilter;
  Param1: ISQLParameter;
begin
  Filter := TSQLFilter.New(TNoneSQLJoin.New);
  Param1 := TstaticSQLParameter.NewWithOutName(TReplaceableSQLParameterValue.New('VALUE'));
  Filter.ConditionList.Add(TEqualSQLCondition.New(TSQLField.New('Field1'), Param1));
  CheckEquals('SELECT * FROM TABLE1 WHERE (Field1=:VALUE) ORDER BY 1', TSQLInjectedFilter.New.Parse(SQL, Filter));
end;

procedure TSQLInjectedFilterTest.InjectWithOutWhere;
const
  SQL = 'SELECT * FROM TABLE1';
var
  Filter: ISQLFilter;
  Param1: ISQLParameter;
begin
  Filter := TSQLFilter.New(TNoneSQLJoin.New);
  Param1 := TstaticSQLParameter.NewWithOutName(TReplaceableSQLParameterValue.New('VALUE'));
  Filter.ConditionList.Add(TEqualSQLCondition.New(TSQLField.New('Field1'), Param1));
  CheckEquals(SQL + ' WHERE (Field1=:VALUE)', TSQLInjectedFilter.New.Parse(SQL, Filter));
end;

procedure TSQLInjectedFilterTest.InjectWithWhere;
const
  SQL = 'SELECT * FROM TABLE1 WHERE TEST_FIELD=666';
var
  Filter: ISQLFilter;
  Param1: ISQLParameter;
begin
  Filter := TSQLFilter.New(TAndSQLJoin.New);
  Param1 := TstaticSQLParameter.NewWithOutName(TReplaceableSQLParameterValue.New('VALUE'));
  Filter.ConditionList.Add(TEqualSQLCondition.New(TSQLField.New('Field1'), Param1));
  CheckEquals(SQL + ' AND (Field1=:VALUE)', TSQLInjectedFilter.New.Parse(SQL, Filter));
end;

procedure TSQLInjectedFilterTest.InjectWithWhereAndOrderBy;
const
  SQL = 'SELECT * FROM TABLE1 WHERE TEST_FIELD=666 ORDER BY 2 DESC';
var
  Filter: ISQLFilter;
  Param1: ISQLParameter;
begin
  Filter := TSQLFilter.New(TAndSQLJoin.New);
  Param1 := TstaticSQLParameter.NewWithOutName(TReplaceableSQLParameterValue.New('VALUE'));
  Filter.ConditionList.Add(TEqualSQLCondition.New(TSQLField.New('Field1'), Param1));
  CheckEquals('SELECT * FROM TABLE1 WHERE TEST_FIELD=666 AND (Field1=:VALUE) ORDER BY 2 DESC',
    TSQLInjectedFilter.New.Parse(SQL, Filter));
end;

initialization

RegisterTest('Statement', TSQLInjectedFilterTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
