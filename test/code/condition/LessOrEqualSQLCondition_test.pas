{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit LessOrEqualSQLCondition_test;

interface

uses
  SysUtils,
  Key,
  SyntaxFormat, SyntaxFormatSymbol, SymbolListMock,
  IntegerSQLParameterValue,
  SQLParameter,
  SQLCondition, SingleSQLCondition,
  LessOrEqualSQLCondition,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TLessOrEqualSQLConditionTest = class sealed(TTestCase)
  published
    procedure KeyIsFieldTest;
    procedure SyntaxIsFieldTestLessOrEqual200;
    procedure IsValidIsTrue;
    procedure EmptyValueReturnIsValidFalse;
    procedure EmptyParamReturnIsValidFalse;
    procedure ParameterContentIs200;
  end;

implementation

procedure TLessOrEqualSQLConditionTest.KeyIsFieldTest;
var
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  Parameter := TSQLParameter.New('Param1');
  Parameter.ChangeValue(TIntegerSQLParameterValue.New(200));
  Condition := TLessOrEqualSQLCondition.New(TTextKey.New('FieldTest'), Parameter,
    TSyntaxFormat.New(TSymbolListMock.New));
  CheckEquals('FieldTest', Condition.Key.Value);
end;

procedure TLessOrEqualSQLConditionTest.SyntaxIsFieldTestLessOrEqual200;
var
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  Parameter := TSQLParameter.New('Param1');
  Parameter.ChangeValue(TIntegerSQLParameterValue.New(200));
  Condition := TLessOrEqualSQLCondition.New(TTextKey.New('FieldTest'), Parameter,
    TSyntaxFormat.New(TSymbolListMock.New));
  CheckEquals('FieldTest <= 200', Condition.Syntax);
end;

procedure TLessOrEqualSQLConditionTest.IsValidIsTrue;
var
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  Parameter := TSQLParameter.New('Param1');
  Parameter.ChangeValue(TIntegerSQLParameterValue.New(200));
  Condition := TLessOrEqualSQLCondition.New(TTextKey.New('FieldTest'), Parameter,
    TSyntaxFormat.New(TSymbolListMock.New));
  CheckTrue(Condition.IsValid);
end;

procedure TLessOrEqualSQLConditionTest.EmptyValueReturnIsValidFalse;
var
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  Parameter := TSQLParameter.New('Param1');
  Condition := TLessOrEqualSQLCondition.New(TTextKey.New('FieldTest'), Parameter,
    TSyntaxFormat.New(TSymbolListMock.New));
  CheckFalse(Condition.IsValid);
end;

procedure TLessOrEqualSQLConditionTest.EmptyParamReturnIsValidFalse;
var
  Condition: ISQLCondition;
begin
  Condition := TLessOrEqualSQLCondition.New(TTextKey.New('FieldTest'), nil, TSyntaxFormat.New(TSymbolListMock.New));
  CheckFalse(Condition.IsValid);
end;

procedure TLessOrEqualSQLConditionTest.ParameterContentIs200;
var
  Parameter: ISQLParameter;
  Condition: ISingleSQLCondition;
begin
  Parameter := TSQLParameter.New('Param1');
  Parameter.ChangeValue(TIntegerSQLParameterValue.New(200));
  Condition := TLessOrEqualSQLCondition.New(TTextKey.New('FieldTest'), Parameter,
    TSyntaxFormat.New(TSymbolListMock.New));
  CheckEquals('200', Condition.Parameter.Value.Syntax);
end;

initialization

RegisterTest(TLessOrEqualSQLConditionTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
