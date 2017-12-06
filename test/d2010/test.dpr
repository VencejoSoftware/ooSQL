{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
program test;

uses
  ooRunTest,
  ooSQL_test in '..\code\ooSQL_test.pas',
  ooSQLParameter_test in '..\code\ooSQLParameter_test.pas',
  ooSQL.Filter.Between_test in '..\code\filter_condition\ooSQL.Filter.Between_test.pas',
  ooSQL.Filter.Equal_test in '..\code\filter_condition\ooSQL.Filter.Equal_test.pas',
  ooSQL.Filter.Greater_test in '..\code\filter_condition\ooSQL.Filter.Greater_test.pas',
  ooSQL.Filter.GreaterOrEqual_test in '..\code\filter_condition\ooSQL.Filter.GreaterOrEqual_test.pas',
  ooSQL.Filter.InList_test in '..\code\filter_condition\ooSQL.Filter.InList_test.pas',
  ooSQL.Filter.IsNotNull_test in '..\code\filter_condition\ooSQL.Filter.IsNotNull_test.pas',
  ooSQL.Filter.IsNull_test in '..\code\filter_condition\ooSQL.Filter.IsNull_test.pas',
  ooSQL.Filter.Less_test in '..\code\filter_condition\ooSQL.Filter.Less_test.pas',
  ooSQL.Filter.LessOrEqual_test in '..\code\filter_condition\ooSQL.Filter.LessOrEqual_test.pas',
  ooSQL.Filter.Like_test in '..\code\filter_condition\ooSQL.Filter.Like_test.pas',
  ooSQL.Filter.NotEqual_test in '..\code\filter_condition\ooSQL.Filter.NotEqual_test.pas',
  ooSQL.Filter.JoinAnd_test in '..\code\filter_join\ooSQL.Filter.JoinAnd_test.pas',
  ooSQL.Filter.JoinAndNot_test in '..\code\filter_join\ooSQL.Filter.JoinAndNot_test.pas',
  ooSQL.Filter.JoinNone_test in '..\code\filter_join\ooSQL.Filter.JoinNone_test.pas',
  ooSQL.Filter.JoinOr_test in '..\code\filter_join\ooSQL.Filter.JoinOr_test.pas',
  ooSQL.Filter.JoinOrNot_test in '..\code\filter_join\ooSQL.Filter.JoinOrNot_test.pas',
  ooSQL.Filter.JoinWhere_test in '..\code\filter_join\ooSQL.Filter.JoinWhere_test.pas',
  ooSQL.Filter.SimpleFormatter_test in '..\code\filter_formatter\ooSQL.Filter.SimpleFormatter_test.pas',
  ooSQLFilter_test in '..\code\ooSQLFilter_test.pas',
  ooSQLSort_test in '..\code\ooSQLSort_test.pas',
  ooSQL.Filter.Inject in '..\..\code\ooSQL.Filter.Inject.pas',
  ooSQL.Filter.Inject_test in '..\code\ooSQL.Filter.Inject_test.pas';

{$R *.RES}

begin
  Run;

end.
