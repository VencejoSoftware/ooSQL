{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit IsNotNullSQLCondition_test;

interface

uses
  SysUtils,
  Key,
  SyntaxFormat, SyntaxFormatSymbol, SymbolListMock,
  SQLCondition,
  IsNotNullSQLCondition,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TIsNotNullSQLConditionTest = class sealed(TTestCase)
  published
    procedure KeyIsFieldTest;
    procedure SyntaxIsFieldTestIsNotNull;
    procedure IsValidIsTrue;
  end;

implementation

procedure TIsNotNullSQLConditionTest.KeyIsFieldTest;
var
  Condition: ISQLCondition;
begin
  Condition := TIsNotNullSQLCondition.New(TTextKey.New('FieldTest'), TSyntaxFormat.New(TSymbolListMock.New));
  CheckEquals('FieldTest', Condition.Key.Value);
end;

procedure TIsNotNullSQLConditionTest.SyntaxIsFieldTestIsNotNull;
var
  Condition: ISQLCondition;
begin
  Condition := TIsNotNullSQLCondition.New(TTextKey.New('FieldTest'), TSyntaxFormat.New(TSymbolListMock.New));
  CheckEquals('FieldTest IS NOT NULL', Condition.Syntax);
end;

procedure TIsNotNullSQLConditionTest.IsValidIsTrue;
var
  Condition: ISQLCondition;
begin
  Condition := TIsNotNullSQLCondition.New(TTextKey.New('FieldTest'), TSyntaxFormat.New(TSymbolListMock.New));
  CheckTrue(Condition.IsValid);
end;

initialization

RegisterTest(TIsNotNullSQLConditionTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
