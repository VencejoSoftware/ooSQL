{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit JoinedSQLCondition_test;

interface

uses
  SysUtils,
  SQLField,
  IntegerSQLParameterValue,
  SQLParameter, StaticSQLParameter,
  SQLCondition,
  EqualSQLCondition,
  NoneSQLJoin, AndSQLJoin, AndNotSQLJoin, OrSQLJoin, OrNotSQLJoin,
  JoinedSQLCondition,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TJoinedSQLConditionTest = class sealed(TTestCase)
  published
    procedure FieldIsParameterField;
    procedure NoneJoinReturnConditionSyntax;
    procedure AndJoinReturnAndConditionSyntax;
    procedure AndNotJoinReturnAndNotConditionSyntax;
    procedure OrJoinReturnOrConditionSyntax;
    procedure OrNotJoinReturnOrNotConditionSyntax;
  end;

implementation

procedure TJoinedSQLConditionTest.FieldIsParameterField;
var
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  Parameter := TStaticSQLParameter.New('Param1', TIntegerSQLParameterValue.New(200));
  Condition := TEqualSQLCondition.New(TSQLField.New('FieldTest'), Parameter);
  CheckEquals('FieldTest', TJoinedSQLCondition.New(TNoneSQLJoin.New, Condition).Field.Name);
end;

procedure TJoinedSQLConditionTest.NoneJoinReturnConditionSyntax;
var
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  Parameter := TStaticSQLParameter.New('Param1', TIntegerSQLParameterValue.New(200));
  Condition := TEqualSQLCondition.New(TSQLField.New('FieldTest'), Parameter);
  CheckEquals('(FieldTest=200)', TJoinedSQLCondition.New(TNoneSQLJoin.New, Condition).Syntax);
end;

procedure TJoinedSQLConditionTest.AndJoinReturnAndConditionSyntax;
var
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  Parameter := TStaticSQLParameter.New('Param1', TIntegerSQLParameterValue.New(200));
  Condition := TEqualSQLCondition.New(TSQLField.New('FieldTest'), Parameter);
  CheckEquals('AND (FieldTest=200)', TJoinedSQLCondition.New(TAndSQLJoin.New, Condition).Syntax);
end;

procedure TJoinedSQLConditionTest.AndNotJoinReturnAndNotConditionSyntax;
var
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  Parameter := TStaticSQLParameter.New('Param1', TIntegerSQLParameterValue.New(200));
  Condition := TEqualSQLCondition.New(TSQLField.New('FieldTest'), Parameter);
  CheckEquals('AND NOT (FieldTest=200)', TJoinedSQLCondition.New(TAndNotSQLJoin.New, Condition).Syntax);
end;

procedure TJoinedSQLConditionTest.OrJoinReturnOrConditionSyntax;
var
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  Parameter := TStaticSQLParameter.New('Param1', TIntegerSQLParameterValue.New(200));
  Condition := TEqualSQLCondition.New(TSQLField.New('FieldTest'), Parameter);
  CheckEquals('OR (FieldTest=200)', TJoinedSQLCondition.New(TOrSQLJoin.New, Condition).Syntax);
end;

procedure TJoinedSQLConditionTest.OrNotJoinReturnOrNotConditionSyntax;
var
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  Parameter := TStaticSQLParameter.New('Param1', TIntegerSQLParameterValue.New(200));
  Condition := TEqualSQLCondition.New(TSQLField.New('FieldTest'), Parameter);
  CheckEquals('OR NOT (FieldTest=200)', TJoinedSQLCondition.New(TOrNotSQLJoin.New, Condition).Syntax);
end;

initialization

RegisterTest('Filter condition', TJoinedSQLConditionTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
