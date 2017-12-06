{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQL.Filter.Inject_test;

interface

uses
  SysUtils,
  ooFilter,
  ooSQL.Filter.Equal,
  ooSQL.Filter.Inject,
  ooSQL.Filter.JoinNone, ooSQL.Filter.JoinWhere, ooSQL.Filter.JoinAnd,
  ooSQL.Filter.SimpleFormatter,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TSQLWhereInjectedTest = class(TTestCase)
  published
    procedure InjectWithOutWhere;
    procedure InjectWithWhere;
    procedure InjectWithOrderBy;
    procedure InjectWithWhereAndOrderBy;
    procedure InjectWithMultipleOrderBy;
  end;

implementation

procedure TSQLWhereInjectedTest.InjectWithMultipleOrderBy;
const
  SQL = 'SELECT (SELECT 1 FROM TABLE 2 ORDER BY 2) FROM TABLE1 ORDER BY 1';
var
  Filter: IFilter;
begin
  Filter := TFilter.New(nil);
  Filter.AddElement(TSQLConditionEqual.New('Field1', ':VALUE'));
  CheckEquals('SELECT (SELECT 1 FROM TABLE 2 ORDER BY 2) FROM TABLE1 WHERE (Field1 = :VALUE) ORDER BY 1',
    TSQLWhereInjected.New(SQL).Parse(Filter, TSQLFilterSimpleFormatter.New));
end;

procedure TSQLWhereInjectedTest.InjectWithOrderBy;
const
  SQL = 'SELECT * FROM TABLE1 ORDER BY 1';
var
  Filter: IFilter;
begin
  Filter := TFilter.New(nil);
  Filter.AddElement(TSQLConditionEqual.New('Field1', ':VALUE'));
  CheckEquals('SELECT * FROM TABLE1 WHERE (Field1 = :VALUE) ORDER BY 1', TSQLWhereInjected.New(SQL).Parse(Filter,
      TSQLFilterSimpleFormatter.New));
end;

procedure TSQLWhereInjectedTest.InjectWithOutWhere;
const
  SQL = 'SELECT * FROM TABLE1';
var
  Filter: IFilter;
begin
  Filter := TFilter.New(nil);
  Filter.AddElement(TSQLConditionEqual.New('Field1', ':VALUE'));
  CheckEquals(SQL + ' WHERE (Field1 = :VALUE)', TSQLWhereInjected.New(SQL).Parse(Filter,
      TSQLFilterSimpleFormatter.New));
end;

procedure TSQLWhereInjectedTest.InjectWithWhere;
const
  SQL = 'SELECT * FROM TABLE1 WHERE TEST_FIELD = 666';
var
  Filter: IFilter;
begin
  Filter := TFilter.New(TSQLJoinAnd.New);
  Filter.AddElement(TSQLConditionEqual.New('Field1', ':VALUE'));
  CheckEquals(SQL + ' AND (Field1 = :VALUE)', TSQLWhereInjected.New(SQL).Parse(Filter,
      TSQLFilterSimpleFormatter.New));
end;

procedure TSQLWhereInjectedTest.InjectWithWhereAndOrderBy;
const
  SQL = 'SELECT * FROM TABLE1 WHERE TEST_FIELD = 666 ORDER BY 2 DESC';
var
  Filter: IFilter;
begin
  Filter := TFilter.New(TSQLJoinAnd.New);
  Filter.AddElement(TSQLConditionEqual.New('Field1', ':VALUE'));
  CheckEquals('SELECT * FROM TABLE1 WHERE TEST_FIELD = 666 AND (Field1 = :VALUE) ORDER BY 2 DESC',
    TSQLWhereInjected.New(SQL).Parse(Filter, TSQLFilterSimpleFormatter.New));
end;

initialization

RegisterTest(TSQLWhereInjectedTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
