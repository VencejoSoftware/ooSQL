{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit SQL_test;

interface

uses
  SysUtils,
  SQLParameterValue, StringSQLParameterValue, IntegerSQLParameterValue, BooleanSQLParameterValue,
  SQLParameter, DynamicSQLParameter,
  SQL,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TSQLTest = class sealed(TTestCase)
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
  ParamList: ISQLParameterList;
begin
  SQL := TSQL.New(SQL_SYNTAX);
  ParamList := TSQLParameterList.New;
  ParamList.Add(TDynamicSQLParameter.New('FIELD_STR1'));
  ParamList.Last.ChangeValue(TStringSQLParameterValue.New('ValueString'));
  ParamList.Add(TDynamicSQLParameter.New('FIELD_INT1'));
  ParamList.Last.ChangeValue(TIntegerSQLParameterValue.New(999));
  ParamList.Add(TDynamicSQLParameter.New('FIELD_BOOL1'));
  ParamList.Last.ChangeValue(TBooleanSQLParameterValue.New(False));
  CheckEquals(SQL_TEST_RESULT, SQL.Parse(ParamList));
end;

procedure TSQLTest.ParseUpdate;
const
  SQL_SYNTAX = 'UPDATE TEST T SET :FIELD_NAME_STR1 = :FIELD_STR1';
  SQL_TEST_RESULT = 'UPDATE TEST T SET FIELD1 = ''ValueString''';
var
  SQL: ISQL;
  Param1, Param2: ISQLParameter;
begin
  SQL := TSQL.New(SQL_SYNTAX);
  Param1 := TDynamicSQLParameter.New('FIELD_NAME_STR1');
  Param1.ChangeValue(TRawSQLParameterValue.New('FIELD1'));
  Param2 := TDynamicSQLParameter.New('FIELD_STR1');
  Param2.ChangeValue(TStringSQLParameterValue.New('ValueString'));
  CheckEquals(SQL_TEST_RESULT, SQL.Parse([Param1, Param2]));
end;

procedure TSQLTest.ParseSelectFilterWithWhere;
const
  SQL_COMMON = 'SELECT * FROM TEST WHERE ';
  SQL_SYNTAX = SQL_COMMON + 'FIELD_STR1 LIKE :FIELD_STR1 AND FIELD_INT1 = :FIELD_INT1 AND FIELD_BOOL1 = :FIELD_BOOL1';
  SQL_SYNTAX_RESULT = SQL_COMMON + 'FIELD_STR1 LIKE ''ValueString''' + ' AND FIELD_INT1 = 999' + ' AND FIELD_BOOL1 = 0';
var
  SQL: ISQL;
  Param1, Param2, Param3: ISQLParameter;
begin
  Param1 := TDynamicSQLParameter.New('FIELD_STR1');
  Param1.ChangeValue(TStringSQLParameterValue.New('ValueString'));
  Param2 := TDynamicSQLParameter.New('FIELD_INT1');
  Param2.ChangeValue(TIntegerSQLParameterValue.New(999));
  Param3 := TDynamicSQLParameter.New('FIELD_BOOL1');
  Param3.ChangeValue(TBooleanSQLParameterValue.New(False));
  SQL := TSQL.New(SQL_SYNTAX);
  CheckEquals(SQL_SYNTAX_RESULT, SQL.Parse([Param1, Param2, Param3]));
end;

initialization

RegisterTest(TSQLTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
