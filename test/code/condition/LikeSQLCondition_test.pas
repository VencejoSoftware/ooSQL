{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit LikeSQLCondition_test;

interface

uses
  SysUtils,
  Key,
  SyntaxFormat, SyntaxFormatSymbol, SymbolListMock,
  IntegerSQLParameterValue,
  SQLParameter,
  SQLCondition, SingleSQLCondition,
  LikeSQLCondition,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TLikeSQLConditionTest = class sealed(TTestCase)
  published
    procedure KeyIsFieldTest;
    procedure SyntaxIsFieldTestLike200;
    procedure IsValidIsTrue;
    procedure EmptyValueReturnIsValidFalse;
    procedure EmptyParamReturnIsValidFalse;
    procedure ParameterContentIs200;
  end;

implementation

procedure TLikeSQLConditionTest.KeyIsFieldTest;
var
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  Parameter := TSQLParameter.New('Param1');
  Parameter.ChangeValue(TIntegerSQLParameterValue.New(200));
  Condition := TLikeSQLCondition.New(TTextKey.New('FieldTest'), Parameter, TSyntaxFormat.New(TSymbolListMock.New));
  CheckEquals('FieldTest', Condition.Key.Value);
end;

procedure TLikeSQLConditionTest.SyntaxIsFieldTestLike200;
var
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  Parameter := TSQLParameter.New('Param1');
  Parameter.ChangeValue(TIntegerSQLParameterValue.New(200));
  Condition := TLikeSQLCondition.New(TTextKey.New('FieldTest'), Parameter, TSyntaxFormat.New(TSymbolListMock.New));
  CheckEquals('FieldTest LIKE 200', Condition.Syntax);
end;

procedure TLikeSQLConditionTest.IsValidIsTrue;
var
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  Parameter := TSQLParameter.New('Param1');
  Parameter.ChangeValue(TIntegerSQLParameterValue.New(200));
  Condition := TLikeSQLCondition.New(TTextKey.New('FieldTest'), Parameter, TSyntaxFormat.New(TSymbolListMock.New));
  CheckTrue(Condition.IsValid);
end;

procedure TLikeSQLConditionTest.EmptyValueReturnIsValidFalse;
var
  Parameter: ISQLParameter;
  Condition: ISQLCondition;
begin
  Parameter := TSQLParameter.New('Param1');
  Condition := TLikeSQLCondition.New(TTextKey.New('FieldTest'), Parameter, TSyntaxFormat.New(TSymbolListMock.New));
  CheckFalse(Condition.IsValid);
end;

procedure TLikeSQLConditionTest.EmptyParamReturnIsValidFalse;
var
  Condition: ISQLCondition;
begin
  Condition := TLikeSQLCondition.New(TTextKey.New('FieldTest'), nil, TSyntaxFormat.New(TSymbolListMock.New));
  CheckFalse(Condition.IsValid);
end;

procedure TLikeSQLConditionTest.ParameterContentIs200;
var
  Parameter: ISQLParameter;
  Condition: ISingleSQLCondition;
begin
  Parameter := TSQLParameter.New('Param1');
  Parameter.ChangeValue(TIntegerSQLParameterValue.New(200));
  Condition := TLikeSQLCondition.New(TTextKey.New('FieldTest'), Parameter, TSyntaxFormat.New(TSymbolListMock.New));
  CheckEquals('200', Condition.Parameter.Value.Syntax);
end;

initialization

RegisterTest(TLikeSQLConditionTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
