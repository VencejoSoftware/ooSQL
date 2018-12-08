{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit BetweenSQLCondition_test;

interface

uses
  SysUtils,
  Key,
  SyntaxFormat, SyntaxFormatSymbol, SymbolListMock,
  IntegerSQLParameterValue,
  SQLParameter,
  SQLCondition,
  BetweenSQLCondition,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TBetweenSQLConditionTest = class sealed(TTestCase)
  published
    procedure KeyIsFieldTest;
    procedure SyntaxIsFieldTestBetween200And300;
    procedure NilValueReturnIsValidFalse;
    procedure ValueNilReturnIsValidFalse;
    procedure BothNilReturnIsValidFalse;
    procedure NullValueReturnIsValidFalse;
    procedure ValueNullReturnIsValidFalse;
  end;

implementation

procedure TBetweenSQLConditionTest.KeyIsFieldTest;
var
  Condition: ISQLCondition;
  Param1: ISQLParameter;
  Param2: ISQLParameter;
begin
  Param1 := TSQLParameter.New('Param1');
  Param1.ChangeValue(TIntegerSQLParameterValue.New(200));
  Param2 := TSQLParameter.New('Param2');
  Param2.ChangeValue(TIntegerSQLParameterValue.New(300));
  Condition := TBetweenSQLCondition.New(TTextKey.New('FieldTest'), Param1, Param2,
    TSyntaxFormat.New(TSymbolListMock.New));
  CheckEquals('FieldTest', Condition.Key.Value);
end;

procedure TBetweenSQLConditionTest.SyntaxIsFieldTestBetween200And300;
var
  Condition: ISQLCondition;
  Param1: ISQLParameter;
  Param2: ISQLParameter;
begin
  Param1 := TSQLParameter.New('Param1');
  Param1.ChangeValue(TIntegerSQLParameterValue.New(200));
  Param2 := TSQLParameter.New('Param2');
  Param2.ChangeValue(TIntegerSQLParameterValue.New(300));
  Condition := TBetweenSQLCondition.New(TTextKey.New('FieldTest'), Param1, Param2,
    TSyntaxFormat.New(TSymbolListMock.New));
  CheckEquals('FieldTest BETWEEN 200 AND 300', Condition.Syntax);
end;

procedure TBetweenSQLConditionTest.NilValueReturnIsValidFalse;
var
  Condition: ISQLCondition;
  Param2: ISQLParameter;
begin
  Param2 := TSQLParameter.New('Param2');
  Param2.ChangeValue(TIntegerSQLParameterValue.New(300));
  Condition := TBetweenSQLCondition.New(TTextKey.New('FieldTest'), nil, Param2, TSyntaxFormat.New(TSymbolListMock.New));
  CheckFalse(Condition.IsValid);
end;

procedure TBetweenSQLConditionTest.ValueNilReturnIsValidFalse;
var
  Condition: ISQLCondition;
  Param1: ISQLParameter;
begin
  Param1 := TSQLParameter.New('Param1');
  Param1.ChangeValue(TIntegerSQLParameterValue.New(200));
  Condition := TBetweenSQLCondition.New(TTextKey.New('FieldTest'), Param1, nil, TSyntaxFormat.New(TSymbolListMock.New));
  CheckFalse(Condition.IsValid);
end;

procedure TBetweenSQLConditionTest.BothNilReturnIsValidFalse;
var
  Condition: ISQLCondition;
begin
  Condition := TBetweenSQLCondition.New(TTextKey.New('FieldTest'), nil, nil, TSyntaxFormat.New(TSymbolListMock.New));
  CheckFalse(Condition.IsValid);
end;

procedure TBetweenSQLConditionTest.NullValueReturnIsValidFalse;
var
  Condition: ISQLCondition;
  Param1: ISQLParameter;
  Param2: ISQLParameter;
begin
  Param1 := TSQLParameter.New('Param1');
  Param2 := TSQLParameter.New('Param2');
  Param2.ChangeValue(TIntegerSQLParameterValue.New(300));
  Condition := TBetweenSQLCondition.New(TTextKey.New('FieldTest'), Param1, Param2,
    TSyntaxFormat.New(TSymbolListMock.New));
  CheckFalse(Condition.IsValid);
end;

procedure TBetweenSQLConditionTest.ValueNullReturnIsValidFalse;
var
  Condition: ISQLCondition;
  Param1: ISQLParameter;
  Param2: ISQLParameter;
begin
  Param1 := TSQLParameter.New('Param1');
  Param1.ChangeValue(TIntegerSQLParameterValue.New(200));
  Param2 := TSQLParameter.New('Param2');
  Condition := TBetweenSQLCondition.New(TTextKey.New('FieldTest'), Param1, Param2,
    TSyntaxFormat.New(TSymbolListMock.New));
  CheckFalse(Condition.IsValid);
end;

initialization

RegisterTest(TBetweenSQLConditionTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
