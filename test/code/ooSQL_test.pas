{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQL_test;

interface

uses
  SysUtils,
  ooText.Beautify.Intf, ooSQL.Filter.SimpleFormatter,
  ooFilter,
  ooFilter.Condition.Joined,
  ooSQL.Filter.JoinNone, ooSQL.Filter.JoinWhere, ooSQL.Filter.JoinAnd,
  ooSQL.Filter.Equal,
  ooSQL.Parameter.Intf,
  ooSQL.Parameter.Str, ooSQL.Parameter.Dbl, ooSQL.Parameter.Bool, ooSQL.Parameter.Date, ooSQL.Parameter.Int,
  ooSQL.Parameter.TimeStamp, ooSQL.Parameter.Text, ooSQL.Parameter.List,
  ooSQL.Intf, ooSQL,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TSQLTest = class(TTestCase)
  private
    _SQL: ISQL;
    function Beautify: ITextBeautify;
  published
    procedure ParseSelect;
    procedure ParseUpdate;
    procedure NewSQL;
    procedure ParseSelectFilterWithoutWhere;
    procedure ParseSelectFilterWithWhere;
    procedure ParseSelectFilterWithWhereAndOrderBy;
  end;

implementation

function TSQLTest.Beautify: ITextBeautify;
begin
  Result := TSQLFilterSimpleFormatter.New;
end;

procedure TSQLTest.NewSQL;
const
  SQL_TEST = 'SELECT * FROM TEST';
begin
  _SQL := TSQL.New(SQL_TEST);
  CheckNotNull(_SQL, 'TSQLParameter is null!');
  CheckEquals(_SQL.SQL, SQL_TEST);
end;

procedure TSQLTest.ParseSelect;
const
  SQL_COMMON = 'SELECT * FROM TEST WHERE ';
  SQL_TEST = SQL_COMMON + ' FIELD_STR1 LIKE :FIELD_STR1 AND FIELD_INT1 = :FIELD_INT1 AND FIELD_BOOL1 = :FIELD_BOOL1';
  SQL_TEST_RESULT = SQL_COMMON + ' FIELD_STR1 LIKE ''ValueString''' + ' AND FIELD_INT1 = 999' + ' AND FIELD_BOOL1 = 0';
begin
  _SQL := TSQL.New(SQL_TEST);
  CheckEquals(SQL_TEST_RESULT, _SQL.Parse([TSQLParameterStr.New('FIELD_STR1', 'ValueString'),
      TSQLParameterInt.New('FIELD_INT1', 999), TSQLParameterBool.New('FIELD_BOOL1', False)], Beautify));
end;

procedure TSQLTest.ParseSelectFilterWithoutWhere;
const
  SQL_COMMON = 'SELECT * FROM TEST ';
  SQL_TEST = SQL_COMMON;
  SQL_TEST_RESULT = SQL_COMMON + ' WHERE ((Field1 = :VALUE))';
var
  Filter: IFilter;
begin
  Filter := TFilter.New(TSQLJoinAnd.New);
  Filter.AddElement(TFilterConditionJoined.New(TSQLJoinNone.New, TSQLConditionEqual.New('Field1', ':VALUE')));
  _SQL := TSQL.New(SQL_TEST, Filter);
  CheckEquals(SQL_TEST_RESULT, _SQL.Parse([], Beautify));
end;

procedure TSQLTest.ParseSelectFilterWithWhere;
const
  SQL_COMMON = 'SELECT * FROM TEST WHERE ';
  SQL_TEST = SQL_COMMON + 'FIELD_STR1 LIKE :FIELD_STR1 AND FIELD_INT1 = :FIELD_INT1 AND FIELD_BOOL1 = :FIELD_BOOL1';
  SQL_TEST_RESULT = SQL_COMMON + 'FIELD_STR1 LIKE ''ValueString''' + ' AND FIELD_INT1 = 999' + ' AND FIELD_BOOL1 = 0' +
    ' AND ((Field1 = :VALUE))';
var
  Filter: IFilter;
begin
  Filter := TFilter.New(TSQLJoinAnd.New);
  Filter.AddElement(TFilterConditionJoined.New(TSQLJoinNone.New, TSQLConditionEqual.New('Field1', ':VALUE')));
  _SQL := TSQL.New(SQL_TEST, Filter);
  CheckEquals(SQL_TEST_RESULT, _SQL.Parse([TSQLParameterStr.New('FIELD_STR1', 'ValueString'),
      TSQLParameterInt.New('FIELD_INT1', 999), TSQLParameterBool.New('FIELD_BOOL1', False)], Beautify));
end;

procedure TSQLTest.ParseSelectFilterWithWhereAndOrderBy;
const
  SQL_COMMON = 'SELECT * FROM TEST WHERE ';
  SQL_TEST = SQL_COMMON +
    'FIELD_STR1 LIKE :FIELD_STR1 AND FIELD_INT1 = :FIELD_INT1 AND FIELD_BOOL1 = :FIELD_BOOL1 ORDER BY FIELD1 ASC;';
  SQL_TEST_RESULT = SQL_COMMON +
    'FIELD_STR1 LIKE ''ValueString'' AND FIELD_INT1 = 999 AND FIELD_BOOL1 = 0 AND ((Field1 = :VALUE)) ORDER BY FIELD1 ASC;';
var
  Filter: IFilter;
begin
  Filter := TFilter.New(TSQLJoinAnd.New);
  Filter.AddElement(TFilterConditionJoined.New(TSQLJoinNone.New, TSQLConditionEqual.New('Field1', ':VALUE')));
  _SQL := TSQL.New(SQL_TEST, Filter);
  CheckEquals(SQL_TEST_RESULT, _SQL.Parse([TSQLParameterStr.New('FIELD_STR1', 'ValueString'),
      TSQLParameterInt.New('FIELD_INT1', 999), TSQLParameterBool.New('FIELD_BOOL1', False)], Beautify));
end;

procedure TSQLTest.ParseUpdate;
const
  SQL_TEST = 'UPDATE TEST T SET :FIELD_NAME_STR1 = :FIELD_STR1';
  SQL_TEST_RESULT = 'UPDATE TEST T SET FIELD1 = ''ValueString''';
begin
  _SQL := TSQL.New(SQL_TEST);
  CheckEquals(SQL_TEST_RESULT, _SQL.Parse([TSQLParameterText.New('FIELD_NAME_STR1', 'FIELD1'),
      TSQLParameterStr.New('FIELD_STR1', 'ValueString')], Beautify));
end;

initialization

RegisterTest(TSQLTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
