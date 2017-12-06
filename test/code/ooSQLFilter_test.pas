{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQLFilter_test;

interface

uses
  SysUtils,
  ooFilter.Condition.Joined,
  ooFilter,
  ooSQL.Filter.SimpleFormatter,
  ooSQL.Filter.JoinNone, ooSQL.Filter.JoinOr, ooSQL.Filter.JoinAnd, ooSQL.Filter.JoinWhere,
  ooSQL.Filter.Equal, ooSQL.Filter.InList,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TSQLFilterTest = class(TTestCase)
  published
    procedure FilterWithNoneOpLog;
    procedure FilterWithTwoConditions;
    procedure FilterWithTwoConditionsAndLogOp;
    procedure FilterWithAnotherFilter;
    procedure FilterIsEmpty;
    procedure FilterIsReplaceable;
    procedure FilterJoinIsNone;
    procedure FilterWhereComplex;
  end;

implementation

procedure TSQLFilterTest.FilterWithNoneOpLog;
var
  Filter: IFilter;
begin
  Filter := TFilter.New(TSQLJoinNone.New);
  Filter.AddElement(TSQLConditionEqual.New('Field1', '22'));
  CheckEquals('(Field1 = 22)', Filter.Parse(TSQLFilterSimpleFormatter.New));
end;

procedure TSQLFilterTest.FilterWithTwoConditions;
var
  Filter: IFilter;
begin
  Filter := TFilter.New(TSQLJoinNone.New);
  Filter.AddElement(TSQLConditionEqual.New('Field1', '22'));
  Filter.AddElement(TFilterConditionJoined.New(TSQLJoinOr.New, TSQLConditionIn.New('Field1', ['1', '5', '10', '15'])));
  CheckEquals('(Field1 = 22 OR (Field1 IN (1, 5, 10, 15)))', Filter.Parse(TSQLFilterSimpleFormatter.New));
end;

procedure TSQLFilterTest.FilterWithTwoConditionsAndLogOp;
var
  Filter: IFilter;
begin
  Filter := TFilter.New(TSQLJoinAnd.New);
  Filter.AddElement(TSQLConditionEqual.New('Field1', '22'));
  Filter.AddElement(TFilterConditionJoined.New(TSQLJoinOr.New, TSQLConditionIn.New('Field1', ['1', '5', '10', '15'])));
  CheckEquals('AND (Field1 = 22 OR (Field1 IN (1, 5, 10, 15)))', Filter.Parse(TSQLFilterSimpleFormatter.New));
end;

procedure TSQLFilterTest.FilterIsEmpty;
begin
  CheckTrue(TFilter.New(TSQLJoinNone.New).IsEmpty);
end;

procedure TSQLFilterTest.FilterIsReplaceable;
var
  Filter: IFilter;
begin
  Filter := TFilter.New(TSQLJoinNone.New);
  Filter.AddElement(TSQLConditionEqual.New('Field1', ':Value'));
  CheckTrue(Filter.IsReplaceable);
end;

procedure TSQLFilterTest.FilterJoinIsNone;
var
  Filter: IFilter;
begin
  Filter := TFilter.New(TSQLJoinNone.New);
  CheckTrue(Filter.Join is TSQLJoinNone);
end;

procedure TSQLFilterTest.FilterWhereComplex;
var
  Filter, InnerFilter: IFilter;
begin
  Filter := TFilter.New(TSQLJoinWhere.New);
  Filter.AddElement(TFilterConditionJoined.New(TSQLJoinNone.New, TSQLConditionEqual.New('Field1', ':VALUE')));
  InnerFilter := TFilter.New(TSQLJoinAnd.New);
  InnerFilter.AddElement(TFilterConditionJoined.New(TSQLJoinNone.New,
      TSQLConditionIn.New('Field1', ['1', '5', '10', '15'])));
  Filter.AddElement(InnerFilter);
  CheckEquals('WHERE ((Field1 = :VALUE) AND ((Field1 IN (1, 5, 10, 15))))',
    Filter.Parse(TSQLFilterSimpleFormatter.New));
end;

procedure TSQLFilterTest.FilterWithAnotherFilter;
var
  Filter, InnerFilter: IFilter;
begin
  Filter := TFilter.New(TSQLJoinNone.New);
  Filter.AddElement(TSQLConditionEqual.New('Field1', '22'));
  InnerFilter := TFilter.New(TSQLJoinAnd.New);
  InnerFilter.AddElement(TSQLConditionEqual.New('Field1', '22'));
  InnerFilter.AddElement(TFilterConditionJoined.New(TSQLJoinOr.New,
      TSQLConditionIn.New('Field1', ['1', '5', '10', '15'])));
  Filter.AddElement(InnerFilter);
  CheckEquals('(Field1 = 22 AND (Field1 = 22 OR (Field1 IN (1, 5, 10, 15))))',
    Filter.Parse(TSQLFilterSimpleFormatter.New));
end;

initialization

RegisterTest(TSQLFilterTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
