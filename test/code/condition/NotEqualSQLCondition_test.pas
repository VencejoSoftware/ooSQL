{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit NotEqualSQLCondition_test;

interface

uses
  SysUtils,
  Key,
  SyntaxFormat, SyntaxFormatSymbol, SymbolListMock,
  IntegerSQLParameterValue,
  SQLParameter,
  SQLCondition, SingleSQLCondition,
  NotEqualSQLCondition,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TNotEqualSQLConditionTest = class sealed(TTestCase)
  published
    procedure KeyIsFieldTest;
    procedure SyntaxIsFieldTestNotEqual200;
    procedure IsValidIsTrue;
    procedure EmptyValueReturnIsValidFalse;
    procedure EmptyParamReturnIsValidFalse;
    procedure ParameterContentIs200;
  end;

implementation

procedure TNotEqualSQLConditionTest.KeyIsFieldTest;
var
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  Parameter := TSQLParameter.New('Param1');
  Parameter.ChangeValue(TIntegerSQLParameterValue.New(200));
  Condition := TNotEqualSQLCondition.New(TTextKey.New('FieldTest'), Parameter, TSyntaxFormat.New(TSymbolListMock.New));
  CheckEquals('FieldTest', Condition.Key.Value);
end;

procedure TNotEqualSQLConditionTest.SyntaxIsFieldTestNotEqual200;
var
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  Parameter := TSQLParameter.New('Param1');
  Parameter.ChangeValue(TIntegerSQLParameterValue.New(200));
  Condition := TNotEqualSQLCondition.New(TTextKey.New('FieldTest'), Parameter, TSyntaxFormat.New(TSymbolListMock.New));
  CheckEquals('FieldTest <> 200', Condition.Syntax);
end;

procedure TNotEqualSQLConditionTest.IsValidIsTrue;
var
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  Parameter := TSQLParameter.New('Param1');
  Parameter.ChangeValue(TIntegerSQLParameterValue.New(200));
  Condition := TNotEqualSQLCondition.New(TTextKey.New('FieldTest'), Parameter, TSyntaxFormat.New(TSymbolListMock.New));
  CheckTrue(Condition.IsValid);
end;

procedure TNotEqualSQLConditionTest.EmptyValueReturnIsValidFalse;
var
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  Parameter := TSQLParameter.New('Param1');
  Condition := TNotEqualSQLCondition.New(TTextKey.New('FieldTest'), Parameter, TSyntaxFormat.New(TSymbolListMock.New));
  CheckFalse(Condition.IsValid);
end;

procedure TNotEqualSQLConditionTest.EmptyParamReturnIsValidFalse;
var
  Condition: ISQLCondition;
begin
  Condition := TNotEqualSQLCondition.New(TTextKey.New('FieldTest'), nil, TSyntaxFormat.New(TSymbolListMock.New));
  CheckFalse(Condition.IsValid);
end;

procedure TNotEqualSQLConditionTest.ParameterContentIs200;
var
  Parameter: ISQLParameter;
  Condition: ISingleSQLCondition;
begin
  Parameter := TSQLParameter.New('Param1');
  Parameter.ChangeValue(TIntegerSQLParameterValue.New(200));
  Condition := TNotEqualSQLCondition.New(TTextKey.New('FieldTest'), Parameter, TSyntaxFormat.New(TSymbolListMock.New));
  CheckEquals('200', Condition.Parameter.Value.Syntax);
end;

initialization

RegisterTest(TNotEqualSQLConditionTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
