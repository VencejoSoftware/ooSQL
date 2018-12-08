{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit GreaterOrEqualSQLCondition_test;

interface

uses
  SysUtils,
  Key,
  SyntaxFormat, SyntaxFormatSymbol, SymbolListMock,
  IntegerSQLParameterValue,
  SQLParameter,
  SQLCondition, SingleSQLCondition,
  GreaterOrEqualSQLCondition,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TGreaterOrEqualSQLConditionTest = class sealed(TTestCase)
  published
    procedure KeyIsFieldTest;
    procedure SyntaxIsFieldTestGreaterOrEqual200;
    procedure IsValidIsTrue;
    procedure EmptyValueReturnIsValidFalse;
    procedure EmptyParamReturnIsValidFalse;
    procedure ParameterContentIs200;
  end;

implementation

procedure TGreaterOrEqualSQLConditionTest.KeyIsFieldTest;
var
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  Parameter := TSQLParameter.New('Param1');
  Parameter.ChangeValue(TIntegerSQLParameterValue.New(200));
  Condition := TGreaterOrEqualSQLCondition.New(TTextKey.New('FieldTest'), Parameter,
    TSyntaxFormat.New(TSymbolListMock.New));
  CheckEquals('FieldTest', Condition.Key.Value);
end;

procedure TGreaterOrEqualSQLConditionTest.SyntaxIsFieldTestGreaterOrEqual200;
var
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  Parameter := TSQLParameter.New('Param1');
  Parameter.ChangeValue(TIntegerSQLParameterValue.New(200));
  Condition := TGreaterOrEqualSQLCondition.New(TTextKey.New('FieldTest'), Parameter,
    TSyntaxFormat.New(TSymbolListMock.New));
  CheckEquals('FieldTest >= 200', Condition.Syntax);
end;

procedure TGreaterOrEqualSQLConditionTest.IsValidIsTrue;
var
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  Parameter := TSQLParameter.New('Param1');
  Parameter.ChangeValue(TIntegerSQLParameterValue.New(200));
  Condition := TGreaterOrEqualSQLCondition.New(TTextKey.New('FieldTest'), Parameter,
    TSyntaxFormat.New(TSymbolListMock.New));
  CheckTrue(Condition.IsValid);
end;

procedure TGreaterOrEqualSQLConditionTest.EmptyValueReturnIsValidFalse;
var
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  Parameter := TSQLParameter.New('Param1');
  Condition := TGreaterOrEqualSQLCondition.New(TTextKey.New('FieldTest'), Parameter,
    TSyntaxFormat.New(TSymbolListMock.New));
  CheckFalse(Condition.IsValid);
end;

procedure TGreaterOrEqualSQLConditionTest.EmptyParamReturnIsValidFalse;
var
  Condition: ISQLCondition;
begin
  Condition := TGreaterOrEqualSQLCondition.New(TTextKey.New('FieldTest'), nil, TSyntaxFormat.New(TSymbolListMock.New));
  CheckFalse(Condition.IsValid);
end;

procedure TGreaterOrEqualSQLConditionTest.ParameterContentIs200;
var
  Parameter: ISQLParameter;
  Condition: ISingleSQLCondition;
begin
  Parameter := TSQLParameter.New('Param1');
  Parameter.ChangeValue(TIntegerSQLParameterValue.New(200));
  Condition := TGreaterOrEqualSQLCondition.New(TTextKey.New('FieldTest'), Parameter,
    TSyntaxFormat.New(TSymbolListMock.New));
  CheckEquals('200', Condition.Parameter.Value.Syntax);
end;

initialization

RegisterTest(TGreaterOrEqualSQLConditionTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
