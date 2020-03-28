{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit SQLFiltered_test;

interface

uses
  SysUtils,
  SQLField,
  SQLParameterValue, StringSQLParameterValue, IntegerSQLParameterValue, BooleanSQLParameterValue,
  SQLParameter, StaticSQLParameter, MutableSQLParameter, ReplaceableSQLParameter,
  SQLFilter,
  NoneSQLJoin, AndSQLJoin,
  EqualSQLCondition, ReplaceableSQLParameterValue, JoinedSQLCondition,
  SQL, SQLFiltered,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TSQLFilteredTest = class sealed(TTestCase)
  published
    procedure SyntaxIsRawSQL;
    procedure FilterIsAssigned;
    procedure ParseSelectWithoutFilterReturnRawSQL;
    procedure ParseSelectWithFilterWithOutConditionReturnRawSQL;
    procedure ParseSelectFilterWithoutWhere;
    procedure ParseSelectAddingFilterAfterWhere;
    procedure ParseSelectAddingFilterAfterWhereAndOrderBy;
    procedure ParseSelectAddingUsingParameterList;
  end;

implementation

procedure TSQLFilteredTest.SyntaxIsRawSQL;
const
  SQL_SYNTAX = 'SELECT * FROM TEST ';
var
  Filter: ISQLFilter;
  SQL: ISQLFiltered;
begin
  Filter := TSQLFilter.New(TNoneSQLJoin.New);
  SQL := TSQLFiltered.New(SQL_SYNTAX, Filter);
  CheckEquals(SQL_SYNTAX, SQL.Syntax);
end;

procedure TSQLFilteredTest.FilterIsAssigned;
const
  SQL_SYNTAX = 'SELECT * FROM TEST';
var
  Filter: ISQLFilter;
  SQL: ISQLFiltered;
begin
  Filter := TSQLFilter.New(TNoneSQLJoin.New);
  SQL := TSQLFiltered.New(SQL_SYNTAX, Filter);
  CheckTrue(Assigned(SQL.Filter));
end;

procedure TSQLFilteredTest.ParseSelectWithoutFilterReturnRawSQL;
const
  SQL_SYNTAX = 'SELECT * FROM TEST';
var
  SQL: ISQLFiltered;
begin
  SQL := TSQLFiltered.New(SQL_SYNTAX, nil);
  CheckEquals(SQL_SYNTAX, SQL.Parse([]).Syntax);
end;

procedure TSQLFilteredTest.ParseSelectWithFilterWithOutConditionReturnRawSQL;
const
  SQL_SYNTAX = 'SELECT * FROM TEST';
var
  Filter: ISQLFilter;
  SQL: ISQLFiltered;
begin
  Filter := TSQLFilter.New(TAndSQLJoin.New);
  SQL := TSQLFiltered.New(SQL_SYNTAX, Filter);
  CheckEquals(SQL_SYNTAX, SQL.Parse([]).Syntax);
end;

procedure TSQLFilteredTest.ParseSelectFilterWithoutWhere;
const
  SQL_COMMON = 'SELECT * FROM TEST ';
  SQL_SYNTAX = SQL_COMMON;
  SQL_SYNTAX_RESULT = SQL_COMMON + ' WHERE ((Field1=:VALUE))';
var
  Filter: ISQLFilter;
  Param1: ISQLParameter;
  SQL: ISQLFiltered;
begin
  Filter := TSQLFilter.New(TNoneSQLJoin.New);
  Param1 := TStaticSQLParameter.NewWithOutName(TReplaceableSQLParameterValue.New('VALUE'));
  Filter.ConditionList.Add(TJoinedSQLCondition.New(TNoneSQLJoin.New, TEqualSQLCondition.New(TSQLField.New('Field1'),
    Param1)));
  SQL := TSQLFiltered.New(SQL_SYNTAX, Filter);
  CheckEquals(SQL_SYNTAX_RESULT, SQL.Parse([]).Syntax);
end;

procedure TSQLFilteredTest.ParseSelectAddingFilterAfterWhere;
const
  SQL_COMMON = 'SELECT * FROM TEST WHERE ';
  SQL_SYNTAX = SQL_COMMON + 'FIELD_STR1 LIKE :FIELD_STR1 AND FIELD_INT1=:FIELD_INT1 AND FIELD_BOOL1=:FIELD_BOOL1';
  SQL_SYNTAX_RESULT = SQL_COMMON + 'FIELD_STR1 LIKE ''ValueString''' + ' AND FIELD_INT1=999' + ' AND FIELD_BOOL1=0' +
    ' AND (Field1=:VALUE)';
var
  Filter: ISQLFilter;
  Param: ISQLParameter;
  Param1, Param2, Param3: IMutableSQLParameter;
  SQL: ISQLFiltered;
begin
  Filter := TSQLFilter.New(TAndSQLJoin.New);
  Param := TStaticSQLParameter.NewWithOutName(TReplaceableSQLParameterValue.New('VALUE'));
  Filter.ConditionList.Add(TEqualSQLCondition.New(TSQLField.New('Field1'), Param));
  SQL := TSQLFiltered.New(SQL_SYNTAX, Filter);
  Param1 := TReplaceableSQLParameter.New('FIELD_STR1');
  Param1.ChangeValue(TStringSQLParameterValue.New('ValueString'));
  Param2 := TReplaceableSQLParameter.New('FIELD_INT1');
  Param2.ChangeValue(TIntegerSQLParameterValue.New(999));
  Param3 := TReplaceableSQLParameter.New('FIELD_BOOL1');
  Param3.ChangeValue(TBooleanSQLParameterValue.New(False));
  CheckEquals(SQL_SYNTAX_RESULT, SQL.Parse([Param1, Param2, Param3]).Syntax);
end;

procedure TSQLFilteredTest.ParseSelectAddingFilterAfterWhereAndOrderBy;
const
  SQL_COMMON = 'SELECT * FROM TEST WHERE ';
  SQL_SYNTAX = SQL_COMMON +
    'FIELD_STR1 LIKE :FIELD_STR1 AND FIELD_INT1=:FIELD_INT1 AND FIELD_BOOL1=:FIELD_BOOL1 ORDER BY FIELD1 ASC;';
  SQL_SYNTAX_RESULT = SQL_COMMON +
    'FIELD_STR1 LIKE ''ValueString'' AND FIELD_INT1=999 AND FIELD_BOOL1=0 AND (Field1=:VALUE) ORDER BY FIELD1 ASC;';
var
  Filter: ISQLFilter;
  Param: IMutableSQLParameter;
  Param1, Param2, Param3: IMutableSQLParameter;
  SQL: ISQLFiltered;
begin
  Filter := TSQLFilter.New(TAndSQLJoin.New);
  Param := TMutableSQLParameter.NewWithOutName;
  Param.ChangeValue(TReplaceableSQLParameterValue.New('VALUE'));
  Filter.ConditionList.Add(TEqualSQLCondition.New(TSQLField.New('Field1'), Param));
  SQL := TSQLFiltered.New(SQL_SYNTAX, Filter);
  Param1 := TReplaceableSQLParameter.New('FIELD_STR1');
  Param1.ChangeValue(TStringSQLParameterValue.New('ValueString'));
  Param2 := TReplaceableSQLParameter.New('FIELD_INT1');
  Param2.ChangeValue(TIntegerSQLParameterValue.New(999));
  Param3 := TReplaceableSQLParameter.New('FIELD_BOOL1');
  Param3.ChangeValue(TBooleanSQLParameterValue.New(False));
  CheckEquals(SQL_SYNTAX_RESULT, SQL.Parse([Param1, Param2, Param3]).Syntax);
end;

procedure TSQLFilteredTest.ParseSelectAddingUsingParameterList;
const
  SQL_COMMON = 'SELECT * FROM TEST WHERE ';
  SQL_SYNTAX = SQL_COMMON + 'FIELD_STR1 LIKE :FIELD_STR1 AND FIELD_INT1=:FIELD_INT1';
  SQL_SYNTAX_RESULT = SQL_COMMON + 'FIELD_STR1 LIKE ''ValueString'' AND FIELD_INT1=999 AND (Field1=:VALUE)';
var
  Filter: ISQLFilter;
  Param: ISQLParameter;
  ParamList: IMutableSQLParameterList;
  SQL: ISQLFiltered;
begin
  Filter := TSQLFilter.New(TAndSQLJoin.New);
  Param := TStaticSQLParameter.NewWithOutName(TReplaceableSQLParameterValue.New('VALUE'));
  Filter.ConditionList.Add(TEqualSQLCondition.New(TSQLField.New('Field1'), Param));
  SQL := TSQLFiltered.New(SQL_SYNTAX, Filter);
  ParamList := TMutableSQLParameterList.New;
  ParamList.Add(TReplaceableSQLParameter.New('FIELD_STR1'));
  ParamList.Last.ChangeValue(TStringSQLParameterValue.New('ValueString'));
  ParamList.Add(TReplaceableSQLParameter.New('FIELD_INT1'));
  ParamList.Last.ChangeValue(TIntegerSQLParameterValue.New(999));
  CheckEquals(SQL_SYNTAX_RESULT, SQL.Parse(ParamList.SQLParameterList).Syntax);
end;

initialization

RegisterTest('Statement', TSQLFilteredTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
