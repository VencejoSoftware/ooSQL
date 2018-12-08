{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit JoinedSQLCondition_test;

interface

uses
  SysUtils,
  Key,
  SyntaxFormat, SyntaxFormatSymbol, SymbolListMock,
  IntegerSQLParameterValue,
  SQLParameter,
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
    procedure KeyIsParameterKey;
    procedure NoneJoinReturnConditionSyntax;
    procedure AndJoinReturnAndConditionSyntax;
    procedure AndNotJoinReturnAndNotConditionSyntax;
    procedure OrJoinReturnOrConditionSyntax;
    procedure OrNotJoinReturnOrNotConditionSyntax;
  end;

implementation

procedure TJoinedSQLConditionTest.KeyIsParameterKey;
var
  SyntaxFormat: ISyntaxFormat;
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  SyntaxFormat := TSyntaxFormat.New(TSymbolListMock.New);
  Parameter := TSQLParameter.New('Param1');
  Parameter.ChangeValue(TIntegerSQLParameterValue.New(200));
  Condition := TEqualSQLCondition.New(TTextKey.New('FieldTest'), Parameter, SyntaxFormat);
  CheckEquals('FieldTest', TJoinedSQLCondition.New(TNoneSQLJoin.New, Condition, SyntaxFormat).Key.Value);
end;

procedure TJoinedSQLConditionTest.NoneJoinReturnConditionSyntax;
var
  SyntaxFormat: ISyntaxFormat;
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  SyntaxFormat := TSyntaxFormat.New(TSymbolListMock.New);
  Parameter := TSQLParameter.New('Param1');
  Parameter.ChangeValue(TIntegerSQLParameterValue.New(200));
  Condition := TEqualSQLCondition.New(TTextKey.New('FieldTest'), Parameter, SyntaxFormat);
  CheckEquals('(FieldTest = 200)', TJoinedSQLCondition.New(TNoneSQLJoin.New, Condition, SyntaxFormat).Syntax);
end;

procedure TJoinedSQLConditionTest.AndJoinReturnAndConditionSyntax;
var
  SyntaxFormat: ISyntaxFormat;
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  SyntaxFormat := TSyntaxFormat.New(TSymbolListMock.New);
  Parameter := TSQLParameter.New('Param1');
  Parameter.ChangeValue(TIntegerSQLParameterValue.New(200));
  Condition := TEqualSQLCondition.New(TTextKey.New('FieldTest'), Parameter, SyntaxFormat);
  CheckEquals('AND (FieldTest = 200)', TJoinedSQLCondition.New(TAndSQLJoin.New, Condition, SyntaxFormat).Syntax);
end;

procedure TJoinedSQLConditionTest.AndNotJoinReturnAndNotConditionSyntax;
var
  SyntaxFormat: ISyntaxFormat;
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  SyntaxFormat := TSyntaxFormat.New(TSymbolListMock.New);
  Parameter := TSQLParameter.New('Param1');
  Parameter.ChangeValue(TIntegerSQLParameterValue.New(200));
  Condition := TEqualSQLCondition.New(TTextKey.New('FieldTest'), Parameter, SyntaxFormat);
  CheckEquals('AND NOT (FieldTest = 200)', TJoinedSQLCondition.New(TAndNotSQLJoin.New, Condition, SyntaxFormat).Syntax);
end;

procedure TJoinedSQLConditionTest.OrJoinReturnOrConditionSyntax;
var
  SyntaxFormat: ISyntaxFormat;
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  SyntaxFormat := TSyntaxFormat.New(TSymbolListMock.New);
  Parameter := TSQLParameter.New('Param1');
  Parameter.ChangeValue(TIntegerSQLParameterValue.New(200));
  Condition := TEqualSQLCondition.New(TTextKey.New('FieldTest'), Parameter, SyntaxFormat);
  CheckEquals('OR (FieldTest = 200)', TJoinedSQLCondition.New(TOrSQLJoin.New, Condition, SyntaxFormat).Syntax);
end;

procedure TJoinedSQLConditionTest.OrNotJoinReturnOrNotConditionSyntax;
var
  SyntaxFormat: ISyntaxFormat;
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  SyntaxFormat := TSyntaxFormat.New(TSymbolListMock.New);
  Parameter := TSQLParameter.New('Param1');
  Parameter.ChangeValue(TIntegerSQLParameterValue.New(200));
  Condition := TEqualSQLCondition.New(TTextKey.New('FieldTest'), Parameter, SyntaxFormat);
  CheckEquals('OR NOT (FieldTest = 200)', TJoinedSQLCondition.New(TOrNotSQLJoin.New, Condition, SyntaxFormat).Syntax);
end;

initialization

RegisterTest(TJoinedSQLConditionTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
