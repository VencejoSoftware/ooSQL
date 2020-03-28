{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit SQL_test;

interface

uses
  SysUtils,
  SQLParameterValue, StringSQLParameterValue, IntegerSQLParameterValue, BooleanSQLParameterValue,
  UIntegerSQLParameterValue,
  SQLParameter, StaticSQLParameter, MutableSQLParameter, ReplaceableSQLParameter, DynamicSQLParameter,
  SQL,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TSQLTest = class sealed(TTestCase)
  private
    function ParameterValueCallback(const Parameter: ISQLParameter): ISQLParameterValue;
  published
    procedure SelectWithoutParseReturnEqualSyntax;
    procedure ParseSelect;
    procedure ParseUpdate;
    procedure ParseSelectFilterWithWhere;
  end;

implementation

procedure TSQLTest.SelectWithoutParseReturnEqualSyntax;
const
  SQL_SYNTAX = 'SELECT * FROM TEST';
var
  SQL: ISQL;
begin
  SQL := TSQL.New(SQL_SYNTAX);
  CheckNotNull(SQL, 'TSQLParameter is null!');
  CheckEquals(SQL_SYNTAX, SQL.Syntax);
end;

procedure TSQLTest.ParseSelect;
const
  SQL_COMMON = 'SELECT * FROM TEST WHERE ';
  SQL_SYNTAX = SQL_COMMON + ' FIELD_STR1 LIKE :FIELD_STR1 AND FIELD_INT1 = :FIELD_INT1 AND FIELD_BOOL1 = :FIELD_BOOL1';
  SQL_TEST_RESULT = SQL_COMMON + ' FIELD_STR1 LIKE ''ValueString''' + ' AND FIELD_INT1 = 999' + ' AND FIELD_BOOL1 = 0';
var
  SQL: ISQL;
  ParamList: IMutableSQLParameterList;
begin
  SQL := TSQL.New(SQL_SYNTAX);
  ParamList := TMutableSQLParameterList.New;
  ParamList.Add(TReplaceableSQLParameter.New('FIELD_STR1'));
  ParamList.Last.ChangeValue(TStringSQLParameterValue.New('ValueString'));
  ParamList.Add(TReplaceableSQLParameter.New('FIELD_INT1'));
  ParamList.Last.ChangeValue(TIntegerSQLParameterValue.New(999));
  ParamList.Add(TReplaceableSQLParameter.New('FIELD_BOOL1'));
  ParamList.Last.ChangeValue(TBooleanSQLParameterValue.New(False));
  CheckEquals(SQL_TEST_RESULT, SQL.Parse(ParamList.SQLParameterList).Syntax);
end;

function TSQLTest.ParameterValueCallback(const Parameter: ISQLParameter): ISQLParameterValue;
begin
  if Parameter.Name = 'PARAM_UINT' then
    Result := TUIntegerSQLParameterValue.New(123);
end;

procedure TSQLTest.ParseUpdate;
const
  SQL_SYNTAX = 'UPDATE TEST T SET :FIELD_NAME_STR1 = :FIELD_STR1, FIELD_INT=:PARAM_UINT';
  SQL_TEST_RESULT = 'UPDATE TEST T SET FIELD1 = ''ValueString'', FIELD_INT=123';
var
  SQL: ISQL;
  Param1, Param2: IMutableSQLParameter;
  ParamInt: ISQLParameter;
begin
  SQL := TSQL.New(SQL_SYNTAX);
  Param1 := TReplaceableSQLParameter.New('FIELD_NAME_STR1');
  Param1.ChangeValue(TSQLParameterValue.New('FIELD1'));
  Param2 := TReplaceableSQLParameter.New('FIELD_STR1');
  Param2.ChangeValue(TStringSQLParameterValue.New('ValueString'));
  ParamInt := TDynamicSQLParameter.New('PARAM_UINT', {$IFDEF FPC}nil, {$ENDIF} ParameterValueCallback);
  CheckEquals(SQL_TEST_RESULT, SQL.Parse([Param1, Param2, ParamInt]).Syntax);
end;

procedure TSQLTest.ParseSelectFilterWithWhere;
const
  SQL_COMMON = 'SELECT * FROM TEST WHERE ';
  SQL_SYNTAX = SQL_COMMON + 'FIELD_STR1 LIKE :FIELD_STR1 AND FIELD_INT1 = :FIELD_INT1 AND FIELD_BOOL1 = :FIELD_BOOL1';
  SQL_SYNTAX_RESULT = SQL_COMMON + 'FIELD_STR1 LIKE ''ValueString''' + ' AND FIELD_INT1 = 999' + ' AND FIELD_BOOL1 = 0';
var
  SQL: ISQL;
  Param1, Param2, Param3: IMutableSQLParameter;
begin
  Param1 := TReplaceableSQLParameter.New('FIELD_STR1');
  Param1.ChangeValue(TStringSQLParameterValue.New('ValueString'));
  Param2 := TReplaceableSQLParameter.New('FIELD_INT1');
  Param2.ChangeValue(TIntegerSQLParameterValue.New(999));
  Param3 := TReplaceableSQLParameter.New('FIELD_BOOL1');
  Param3.ChangeValue(TBooleanSQLParameterValue.New(False));
  SQL := TSQL.New(SQL_SYNTAX);
  CheckEquals(SQL_SYNTAX_RESULT, SQL.Parse([Param1, Param2, Param3]).Syntax);
end;

initialization

RegisterTest('Statement', TSQLTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
