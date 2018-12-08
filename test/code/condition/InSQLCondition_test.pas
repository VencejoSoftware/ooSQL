{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit InSQLCondition_test;

interface

uses
  SysUtils,
  Key,
  SyntaxFormat, SyntaxFormatSymbol, SymbolListMock,
  IntegerSQLParameterValue,
  SQLParameter,
  SQLCondition,
  InSQLCondition,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TInSQLConditionTest = class sealed(TTestCase)
  published
    procedure KeyIsFieldTest;
    procedure SyntaxIsFieldTestIn1234;
    procedure EmptyConditionReturnSyntaxEnclosed;
    procedure EmptyConditionReturnIsValidFalse;
    procedure TwoParamsWithOneValueNilReturnIsValidFalse;
    procedure WithItemsReturnIsValidTrue;
  end;

implementation

procedure TInSQLConditionTest.KeyIsFieldTest;
var
  Condition: ISQLCondition;
begin
  Condition := TInSQLCondition.New(TTextKey.New('FieldTest'), [], TSyntaxFormat.New(TSymbolListMock.New));
  CheckEquals('FieldTest', Condition.Key.Value);
end;

procedure TInSQLConditionTest.SyntaxIsFieldTestIn1234;
var
  Condition: ISQLCondition;
  Param1: ISQLParameter;
  Param2: ISQLParameter;
  Param3: ISQLParameter;
  Param4: ISQLParameter;
begin
  Param1 := TSQLParameter.New('Param1');
  Param1.ChangeValue(TIntegerSQLParameterValue.New(1));
  Param2 := TSQLParameter.New('Param2');
  Param2.ChangeValue(TIntegerSQLParameterValue.New(2));
  Param3 := TSQLParameter.New('Param3');
  Param3.ChangeValue(TIntegerSQLParameterValue.New(3));
  Param4 := TSQLParameter.New('Param4');
  Param4.ChangeValue(TIntegerSQLParameterValue.New(4));
  Condition := TInSQLCondition.New(TTextKey.New('FieldTest'), [Param1, Param2, Param3, Param4],
    TSyntaxFormat.New(TSymbolListMock.New));
  CheckEquals('FieldTest IN (1, 2, 3, 4)', Condition.Syntax);
end;

procedure TInSQLConditionTest.EmptyConditionReturnSyntaxEnclosed;
var
  Condition: ISQLCondition;
begin
  Condition := TInSQLCondition.New(TTextKey.New('FieldTest'), [], TSyntaxFormat.New(TSymbolListMock.New));
  CheckEquals('FieldTest IN ()', Condition.Syntax);
end;

procedure TInSQLConditionTest.EmptyConditionReturnIsValidFalse;
var
  Condition: ISQLCondition;
begin
  Condition := TInSQLCondition.New(TTextKey.New('FieldTest'), [], TSyntaxFormat.New(TSymbolListMock.New));
  CheckFalse(Condition.IsValid);
end;

procedure TInSQLConditionTest.TwoParamsWithOneValueNilReturnIsValidFalse;
var
  Condition: ISQLCondition;
  Param1: ISQLParameter;
  Param2: ISQLParameter;
begin
  Param1 := TSQLParameter.New('Param1');
  Param1.ChangeValue(TIntegerSQLParameterValue.New(1));
  Param2 := TSQLParameter.New('Param2');
  Condition := TInSQLCondition.New(TTextKey.New('FieldTest'), [Param1, Param2],
    TSyntaxFormat.New(TSymbolListMock.New));
  CheckFalse(Condition.IsValid);
end;

procedure TInSQLConditionTest.WithItemsReturnIsValidTrue;
var
  Condition: ISQLCondition;
  Param1: ISQLParameter;
  Param2: ISQLParameter;
  Param3: ISQLParameter;
  Param4: ISQLParameter;
begin
  Param1 := TSQLParameter.New('Param1');
  Param1.ChangeValue(TIntegerSQLParameterValue.New(1));
  Param2 := TSQLParameter.New('Param2');
  Param2.ChangeValue(TIntegerSQLParameterValue.New(2));
  Param3 := TSQLParameter.New('Param3');
  Param3.ChangeValue(TIntegerSQLParameterValue.New(3));
  Param4 := TSQLParameter.New('Param4');
  Param4.ChangeValue(TIntegerSQLParameterValue.New(4));
  Condition := TInSQLCondition.New(TTextKey.New('FieldTest'), [Param1, Param2, Param3, Param4],
    TSyntaxFormat.New(TSymbolListMock.New));
  CheckTrue(Condition.IsValid);
end;

initialization

RegisterTest(TInSQLConditionTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
