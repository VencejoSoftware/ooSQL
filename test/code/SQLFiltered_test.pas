{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit SQLFiltered_test;

interface

uses
  SysUtils,
  SyntaxFormat, SyntaxFormatSymbol, SymbolListMock,
  Key,
  SQLParameterValue, StringSQLParameterValue, IntegerSQLParameterValue, BooleanSQLParameterValue,
  SQLParameter, DynamicSQLParameter,
  SQLFilter,
  NoneSQLJoin, AndSQLJoin,
  EqualSQLCondition, DynamicSQLParameterValue, JoinedSQLCondition,
  SQL, SQLFiltered,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TSQLFilteredTest = class sealed(TTestCase)
  private
    function DefaultSyntaxFormat: ISyntaxFormat;
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

function TSQLFilteredTest.DefaultSyntaxFormat: ISyntaxFormat;
begin
  Result := TSyntaxFormat.New(TSymbolListMock.New);
end;

procedure TSQLFilteredTest.SyntaxIsRawSQL;
const
  SQL_SYNTAX = 'SELECT * FROM TEST ';
var
  Filter: ISQLFilter;
  SQL: ISQLFiltered;
begin
  Filter := TSQLFilter.New(TNoneSQLJoin.New, DefaultSyntaxFormat);
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
  Filter := TSQLFilter.New(TNoneSQLJoin.New, DefaultSyntaxFormat);
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
  Filter := TSQLFilter.New(TAndSQLJoin.New, DefaultSyntaxFormat);
  SQL := TSQLFiltered.New(SQL_SYNTAX, Filter);
  CheckEquals(SQL_SYNTAX, SQL.Parse([]).Syntax);
end;

procedure TSQLFilteredTest.ParseSelectFilterWithoutWhere;
const
  SQL_COMMON = 'SELECT * FROM TEST ';
  SQL_SYNTAX = SQL_COMMON;
  SQL_SYNTAX_RESULT = SQL_COMMON + ' WHERE ((Field1 = :VALUE))';
var
  Filter: ISQLFilter;
  Param1: ISQLParameter;
  SQL: ISQLFiltered;
begin
  Filter := TSQLFilter.New(TNoneSQLJoin.New, DefaultSyntaxFormat);
  Param1 := TSQLParameter.NewWithOutName;
  Param1.ChangeValue(TDynamicSQLParameterValue.New('VALUE'));
  Filter.ConditionList.Add(TJoinedSQLCondition.New(TNoneSQLJoin.New, TEqualSQLCondition.New(TTextKey.New('Field1'),
    Param1, DefaultSyntaxFormat), DefaultSyntaxFormat));
  SQL := TSQLFiltered.New(SQL_SYNTAX, Filter);
  CheckEquals(SQL_SYNTAX_RESULT, SQL.Parse([]).Syntax);
end;

procedure TSQLFilteredTest.ParseSelectAddingFilterAfterWhere;
const
  SQL_COMMON = 'SELECT * FROM TEST WHERE ';
  SQL_SYNTAX = SQL_COMMON + 'FIELD_STR1 LIKE :FIELD_STR1 AND FIELD_INT1 = :FIELD_INT1 AND FIELD_BOOL1 = :FIELD_BOOL1';
  SQL_SYNTAX_RESULT = SQL_COMMON + 'FIELD_STR1 LIKE ''ValueString''' + ' AND FIELD_INT1 = 999' + ' AND FIELD_BOOL1 = 0'
    + ' AND (Field1 = :VALUE)';
var
  Filter: ISQLFilter;
  Param1, Param2, Param3, Param: ISQLParameter;
  SQL: ISQLFiltered;
begin
  Filter := TSQLFilter.New(TAndSQLJoin.New, DefaultSyntaxFormat);
  Param := TSQLParameter.NewWithOutName;
  Param.ChangeValue(TDynamicSQLParameterValue.New('VALUE'));
  Filter.ConditionList.Add(TEqualSQLCondition.New(TTextKey.New('Field1'), Param, DefaultSyntaxFormat));
  SQL := TSQLFiltered.New(SQL_SYNTAX, Filter);
  Param1 := TDynamicSQLParameter.New('FIELD_STR1');
  Param1.ChangeValue(TStringSQLParameterValue.New('ValueString'));
  Param2 := TDynamicSQLParameter.New('FIELD_INT1');
  Param2.ChangeValue(TIntegerSQLParameterValue.New(999));
  Param3 := TDynamicSQLParameter.New('FIELD_BOOL1');
  Param3.ChangeValue(TBooleanSQLParameterValue.New(False));
  CheckEquals(SQL_SYNTAX_RESULT, SQL.Parse([Param1, Param2, Param3]).Syntax);
end;

procedure TSQLFilteredTest.ParseSelectAddingFilterAfterWhereAndOrderBy;
const
  SQL_COMMON = 'SELECT * FROM TEST WHERE ';
  SQL_SYNTAX = SQL_COMMON +
    'FIELD_STR1 LIKE :FIELD_STR1 AND FIELD_INT1 = :FIELD_INT1 AND FIELD_BOOL1 = :FIELD_BOOL1 ORDER BY FIELD1 ASC;';
  SQL_SYNTAX_RESULT = SQL_COMMON +
    'FIELD_STR1 LIKE ''ValueString'' AND FIELD_INT1 = 999 AND FIELD_BOOL1 = 0 AND (Field1 = :VALUE) ORDER BY FIELD1 ASC;';
var
  Filter: ISQLFilter;
  Param1, Param2, Param3, Param: ISQLParameter;
  SQL: ISQLFiltered;
begin
  Filter := TSQLFilter.New(TAndSQLJoin.New, DefaultSyntaxFormat);
  Param := TSQLParameter.NewWithOutName;
  Param.ChangeValue(TDynamicSQLParameterValue.New('VALUE'));
  Filter.ConditionList.Add(TEqualSQLCondition.New(TTextKey.New('Field1'), Param, DefaultSyntaxFormat));
  SQL := TSQLFiltered.New(SQL_SYNTAX, Filter);
  Param1 := TDynamicSQLParameter.New('FIELD_STR1');
  Param1.ChangeValue(TStringSQLParameterValue.New('ValueString'));
  Param2 := TDynamicSQLParameter.New('FIELD_INT1');
  Param2.ChangeValue(TIntegerSQLParameterValue.New(999));
  Param3 := TDynamicSQLParameter.New('FIELD_BOOL1');
  Param3.ChangeValue(TBooleanSQLParameterValue.New(False));
  CheckEquals(SQL_SYNTAX_RESULT, SQL.Parse([Param1, Param2, Param3]).Syntax);
end;

procedure TSQLFilteredTest.ParseSelectAddingUsingParameterList;
const
  SQL_COMMON = 'SELECT * FROM TEST WHERE ';
  SQL_SYNTAX = SQL_COMMON + 'FIELD_STR1 LIKE :FIELD_STR1 AND FIELD_INT1 = :FIELD_INT1';
  SQL_SYNTAX_RESULT = SQL_COMMON + 'FIELD_STR1 LIKE ''ValueString''' + ' AND FIELD_INT1 = 999' +
    ' AND (Field1 = :VALUE)';
var
  Filter: ISQLFilter;
  Param: ISQLParameter;
  ParamList: ISQLParameterList;
  SQL: ISQLFiltered;
begin
  Filter := TSQLFilter.New(TAndSQLJoin.New, DefaultSyntaxFormat);
  Param := TSQLParameter.NewWithOutName;
  Param.ChangeValue(TDynamicSQLParameterValue.New('VALUE'));
  Filter.ConditionList.Add(TEqualSQLCondition.New(TTextKey.New('Field1'), Param, DefaultSyntaxFormat));
  SQL := TSQLFiltered.New(SQL_SYNTAX, Filter);
  ParamList := TSQLParameterList.New;
  ParamList.Add(TDynamicSQLParameter.New('FIELD_STR1'));
  ParamList.Last.ChangeValue(TStringSQLParameterValue.New('ValueString'));
  ParamList.Add(TDynamicSQLParameter.New('FIELD_INT1'));
  ParamList.Last.ChangeValue(TIntegerSQLParameterValue.New(999));
  CheckEquals(SQL_SYNTAX_RESULT, SQL.Parse(ParamList).Syntax);
end;

initialization

RegisterTest(TSQLFilteredTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
