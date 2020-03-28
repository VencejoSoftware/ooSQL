{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit StoredSQL_test;

interface

uses
  Classes, SysUtils,
  ResourceStoredText,
  SQLParameter, DynamicSQLParameter, StaticSQLParameter,
  SQLParameterValue, DateSQLParameterValue, DateTimeSQLParameterValue, IntegerSQLParameterValue,
  ExtendedSQLParameterValue,
  SQL, SQLFiltered, StoredSQL,
  AndSQLJoin, NoneSQLJoin,
  EqualSQLCondition, NotEqualSQLCondition, JoinedSQLCondition,
  RawSQLCondition,
  SQLField,
  SQLFilter,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TStoredSQLTest = class sealed(TTestCase)
  private
    function ParameterValueCallback(const Parameter: ISQLParameter): ISQLParameterValue;
  published
    procedure SintaxIsSQL;
    procedure ParametrizedReturnSQL;
    procedure ParseReturnResolvedSQL;
    procedure ParseByArrayReturnResolvedSQL;
  end;

implementation

procedure TStoredSQLTest.SintaxIsSQL;
const
  TEXT = 'SELECT FIELD1, Field2, ''ñ''' + sLineBreak + 'FROM TEST' + sLineBreak + 'WHERE' + sLineBreak +
    '  FIELD1 = :FIELD + 1' + sLineBreak + 'ORDER BY' + sLineBreak + '  FIELD1;' + sLineBreak;
begin
  CheckEquals(TEXT, TStoredSQL.New(TResourceStoredText.New('ID_SQL1')).Syntax);
end;

function TStoredSQLTest.ParameterValueCallback(const Parameter: ISQLParameter): ISQLParameterValue;
begin
  if CompareText(Parameter.Name, 'Param1') = 0 then
    Result := TDateSQLParameterValue.New(Now);
  if CompareText(Parameter.Name, 'Param2') = 0 then
    Result := TExtendedSQLParameterValue.NewDefault(12.123);
  if CompareText(Parameter.Name, 'Param1a') = 0 then
    Result := TIntegerSQLParameterValue.New(666);
  if CompareText(Parameter.Name, 'DYNAMIC_FIELD') = 0 then
    Result := TDateTimeSQLParameterValue.New(EncodeDate(2019, 10, 11), 'mm-dd-yyyy');
end;

procedure TStoredSQLTest.ParametrizedReturnSQL;
const
  TEXT = 'SELECT 1' + #$A + 'FROM TABLE' + #$A + 'WHERE' + #$A + '  FIELD1 = ''%s''' + #$A + '  AND FIELD2 = 12.1230' +
    #$A + '  AND FIELD3 = 666' + ' AND ((STATIC_FIELD = 123)' + ' AND (DYNAMIC_FIELD<>''10-11-2019''))';
var
  SQL: ISQLFiltered;
  Filter: ISQLFilter;
  ParameterList: ISQLParameterList;
begin
  Filter := TSQLFilter.New(TAndSQLJoin.New);
  Filter.ConditionList.Add(TRawSQLCondition.New('(STATIC_FIELD = 123)'));
  Filter.ConditionList.Add(TJoinedSQLCondition.New(TAndSQLJoin.New,
    TNotEqualSQLCondition.New(TSQLField.New('DYNAMIC_FIELD'), TDynamicSQLParameter.New('DYNAMIC_FIELD',
{$IFDEF FPC}nil, {$ENDIF}ParameterValueCallback))));
  SQL := TSQLFiltered.New(TStoredSQL.New(TResourceStoredText.New('ID_SQL_PARAM')).Syntax, Filter);
  ParameterList := TSQLParameterList.New;
  ParameterList.Add(TDynamicSQLParameter.New('Param1', {$IFDEF FPC}nil, {$ENDIF}ParameterValueCallback));
  ParameterList.Add(TDynamicSQLParameter.New('Param2', {$IFDEF FPC}nil, {$ENDIF}ParameterValueCallback));
  ParameterList.Add(TDynamicSQLParameter.New('Param1a', {$IFDEF FPC}nil, {$ENDIF}ParameterValueCallback));
  CheckEquals(Format(TEXT, [FormatDateTime('DD/MM/YYYY', Now)]), SQL.Parse(ParameterList).Syntax);
end;

procedure TStoredSQLTest.ParseByArrayReturnResolvedSQL;
const
  TEXT = 'SELECT 1' + #$A + 'FROM TABLE' + #$A + 'WHERE' + #$A + '  FIELD1 = ''%s''' + #$A + '  AND FIELD2 = 12.1230' +
    #$A + '  AND FIELD3 = 666';
var
  SQL: ISQL;
  Param1, Param2, Param3: ISQLParameter;
begin
  SQL := TStoredSQL.New(TResourceStoredText.New('ID_SQL_PARAM'));
  Param1 := TDynamicSQLParameter.New('Param1', {$IFDEF FPC}nil, {$ENDIF}ParameterValueCallback);
  Param2 := TDynamicSQLParameter.New('Param2', {$IFDEF FPC}nil, {$ENDIF}ParameterValueCallback);
  Param3 := TDynamicSQLParameter.New('Param1a', {$IFDEF FPC}nil, {$ENDIF}ParameterValueCallback);
  CheckEquals(Format(TEXT, [FormatDateTime('DD/MM/YYYY', Now)]), SQL.Parse([Param1, Param2, Param3]).Syntax);

end;

procedure TStoredSQLTest.ParseReturnResolvedSQL;
const
  TEXT = 'SELECT 1' + #$A + 'FROM TABLE' + #$A + 'WHERE' + #$A + '  FIELD1 = ''%s''' + #$A + '  AND FIELD2 = 12.1230' +
    #$A + '  AND FIELD3 = 666';
var
  SQL: ISQL;
  ParameterList: ISQLParameterList;
begin
  SQL := TStoredSQL.New(TResourceStoredText.New('ID_SQL_PARAM'));
  ParameterList := TSQLParameterList.New;
  ParameterList.Add(TDynamicSQLParameter.New('Param1', {$IFDEF FPC}nil, {$ENDIF}ParameterValueCallback));
  ParameterList.Add(TDynamicSQLParameter.New('Param2', {$IFDEF FPC}nil, {$ENDIF}ParameterValueCallback));
  ParameterList.Add(TDynamicSQLParameter.New('Param1a', {$IFDEF FPC}nil, {$ENDIF}ParameterValueCallback));
  CheckEquals(Format(TEXT, [FormatDateTime('DD/MM/YYYY', Now)]), SQL.Parse(ParameterList).Syntax);
end;

initialization

RegisterTest('Stored', TStoredSQLTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
