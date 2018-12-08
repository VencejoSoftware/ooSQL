{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit SQLInjectedFilter_test;

interface

uses
  SysUtils,
  Key,
  SyntaxFormat, SyntaxFormatSymbol, SymbolListMock,
  SQLFilter,
  EqualSQLCondition,
  SQLInjectedFilter,
  NoneSQLJoin, WhereSQL, AndSQLJoin,
  DynamicSQLParameterValue,
  SQLParameter,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TSQLInjectedFilterTest = class sealed(TTestCase)
  private
    function DefaultSyntaxFormat: ISyntaxFormat;
  published
    procedure InjectWithOutWhere;
    procedure InjectWithWhere;
    procedure InjectWithOrderBy;
    procedure InjectWithWhereAndOrderBy;
    procedure InjectWithMultipleOrderBy;
  end;

implementation

function TSQLInjectedFilterTest.DefaultSyntaxFormat: ISyntaxFormat;
begin
  Result := TSyntaxFormat.New(TSymbolListMock.New);
end;

procedure TSQLInjectedFilterTest.InjectWithMultipleOrderBy;
const
  SQL = 'SELECT (SELECT 1 FROM TABLE 2 ORDER BY 2) FROM TABLE1 ORDER BY 1';
var
  Filter: ISQLFilter;
  Param1: ISQLParameter;
begin
  Filter := TSQLFilter.New(TNoneSQLJoin.New, DefaultSyntaxFormat);
  Param1 := TSQLParameter.NewWithOutName;
  Param1.ChangeValue(TDynamicSQLParameterValue.New('VALUE'));
  Filter.ConditionList.Add(TEqualSQLCondition.New(TTextKey.New('Field1'), Param1, DefaultSyntaxFormat));
  CheckEquals('SELECT (SELECT 1 FROM TABLE 2 ORDER BY 2) FROM TABLE1 WHERE (Field1 = :VALUE) ORDER BY 1',
    TSQLInjectedFilter.New.Parse(SQL, Filter));
end;

procedure TSQLInjectedFilterTest.InjectWithOrderBy;
const
  SQL = 'SELECT * FROM TABLE1 ORDER BY 1';
var
  Filter: ISQLFilter;
  Param1: ISQLParameter;
begin
  Filter := TSQLFilter.New(TNoneSQLJoin.New, DefaultSyntaxFormat);
  Param1 := TSQLParameter.NewWithOutName;
  Param1.ChangeValue(TDynamicSQLParameterValue.New('VALUE'));
  Filter.ConditionList.Add(TEqualSQLCondition.New(TTextKey.New('Field1'), Param1, DefaultSyntaxFormat));
  CheckEquals('SELECT * FROM TABLE1 WHERE (Field1 = :VALUE) ORDER BY 1', TSQLInjectedFilter.New.Parse(SQL, Filter));
end;

procedure TSQLInjectedFilterTest.InjectWithOutWhere;
const
  SQL = 'SELECT * FROM TABLE1';
var
  Filter: ISQLFilter;
  Param1: ISQLParameter;
begin
  Filter := TSQLFilter.New(TNoneSQLJoin.New, DefaultSyntaxFormat);
  Param1 := TSQLParameter.NewWithOutName;
  Param1.ChangeValue(TDynamicSQLParameterValue.New('VALUE'));
  Filter.ConditionList.Add(TEqualSQLCondition.New(TTextKey.New('Field1'), Param1, DefaultSyntaxFormat));
  CheckEquals(SQL + ' WHERE (Field1 = :VALUE)', TSQLInjectedFilter.New.Parse(SQL, Filter));
end;

procedure TSQLInjectedFilterTest.InjectWithWhere;
const
  SQL = 'SELECT * FROM TABLE1 WHERE TEST_FIELD = 666';
var
  Filter: ISQLFilter;
  Param1: ISQLParameter;
begin
  Filter := TSQLFilter.New(TAndSQLJoin.New, DefaultSyntaxFormat);
  Param1 := TSQLParameter.NewWithOutName;
  Param1.ChangeValue(TDynamicSQLParameterValue.New('VALUE'));
  Filter.ConditionList.Add(TEqualSQLCondition.New(TTextKey.New('Field1'), Param1, DefaultSyntaxFormat));
  CheckEquals(SQL + ' AND (Field1 = :VALUE)', TSQLInjectedFilter.New.Parse(SQL, Filter));
end;

procedure TSQLInjectedFilterTest.InjectWithWhereAndOrderBy;
const
  SQL = 'SELECT * FROM TABLE1 WHERE TEST_FIELD = 666 ORDER BY 2 DESC';
var
  Filter: ISQLFilter;
  Param1: ISQLParameter;
begin
  Filter := TSQLFilter.New(TAndSQLJoin.New, DefaultSyntaxFormat);
  Param1 := TSQLParameter.NewWithOutName;
  Param1.ChangeValue(TDynamicSQLParameterValue.New('VALUE'));
  Filter.ConditionList.Add(TEqualSQLCondition.New(TTextKey.New('Field1'), Param1, DefaultSyntaxFormat));
  CheckEquals('SELECT * FROM TABLE1 WHERE TEST_FIELD = 666 AND (Field1 = :VALUE) ORDER BY 2 DESC',
    TSQLInjectedFilter.New.Parse(SQL, Filter));
end;

initialization

RegisterTest(TSQLInjectedFilterTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
