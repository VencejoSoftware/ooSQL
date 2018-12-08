{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit EqualSQLCondition_test;

interface

uses
  SysUtils,
  Key,
  SyntaxFormat, SyntaxFormatSymbol, SymbolListMock,
  IntegerSQLParameterValue,
  SQLParameter,
  SQLCondition, SingleSQLCondition,
  EqualSQLCondition,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TEqualSQLConditionTest = class sealed(TTestCase)
  published
    procedure KeyIsFieldTest;
    procedure SyntaxIsFieldTestEqual200;
    procedure IsValidIsTrue;
    procedure EmptyValueReturnIsValidFalse;
    procedure EmptyParamReturnIsValidFalse;
    procedure ParameterContentIs200;
  end;

implementation

procedure TEqualSQLConditionTest.KeyIsFieldTest;
var
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  Parameter := TSQLParameter.New('Param1');
  Parameter.ChangeValue(TIntegerSQLParameterValue.New(200));
  Condition := TEqualSQLCondition.New(TTextKey.New('FieldTest'), Parameter, TSyntaxFormat.New(TSymbolListMock.New));
  CheckEquals('FieldTest', Condition.Key.Value);
end;

procedure TEqualSQLConditionTest.SyntaxIsFieldTestEqual200;
var
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  Parameter := TSQLParameter.New('Param1');
  Parameter.ChangeValue(TIntegerSQLParameterValue.New(200));
  Condition := TEqualSQLCondition.New(TTextKey.New('FieldTest'), Parameter, TSyntaxFormat.New(TSymbolListMock.New));
  CheckEquals('FieldTest = 200', Condition.Syntax);
end;

procedure TEqualSQLConditionTest.IsValidIsTrue;
var
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  Parameter := TSQLParameter.New('Param1');
  Parameter.ChangeValue(TIntegerSQLParameterValue.New(200));
  Condition := TEqualSQLCondition.New(TTextKey.New('FieldTest'), Parameter, TSyntaxFormat.New(TSymbolListMock.New));
  CheckTrue(Condition.IsValid);
end;

procedure TEqualSQLConditionTest.EmptyValueReturnIsValidFalse;
var
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  Parameter := TSQLParameter.New('Param1');
  Condition := TEqualSQLCondition.New(TTextKey.New('FieldTest'), Parameter, TSyntaxFormat.New(TSymbolListMock.New));
  CheckFalse(Condition.IsValid);
end;

procedure TEqualSQLConditionTest.EmptyParamReturnIsValidFalse;
var
  Condition: ISQLCondition;
begin
  Condition := TEqualSQLCondition.New(TTextKey.New('FieldTest'), nil, TSyntaxFormat.New(TSymbolListMock.New));
  CheckFalse(Condition.IsValid);
end;

procedure TEqualSQLConditionTest.ParameterContentIs200;
var
  Parameter: ISQLParameter;
  Condition: ISingleSQLCondition;
begin
  Parameter := TSQLParameter.New('Param1');
  Parameter.ChangeValue(TIntegerSQLParameterValue.New(200));
  Condition := TEqualSQLCondition.New(TTextKey.New('FieldTest'), Parameter, TSyntaxFormat.New(TSymbolListMock.New));
  CheckEquals('200', Condition.Parameter.Value.Syntax);
end;

initialization

RegisterTest(TEqualSQLConditionTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
