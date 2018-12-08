{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit IsNullSQLCondition_test;

interface

uses
  SysUtils,
  Key,
  SyntaxFormat, SyntaxFormatSymbol, SymbolListMock,
  SQLCondition,
  IsNullSQLCondition,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TIsNullSQLConditionTest = class sealed(TTestCase)
  published
    procedure KeyIsFieldTest;
    procedure SyntaxIsFieldTestIsNull;
    procedure IsValidIsTrue;
  end;

implementation

procedure TIsNullSQLConditionTest.KeyIsFieldTest;
var
  Condition: ISQLCondition;
begin
  Condition := TIsNullSQLCondition.New(TTextKey.New('FieldTest'), TSyntaxFormat.New(TSymbolListMock.New));
  CheckEquals('FieldTest', Condition.Key.Value);
end;

procedure TIsNullSQLConditionTest.SyntaxIsFieldTestIsNull;
var
  Condition: ISQLCondition;
begin
  Condition := TIsNullSQLCondition.New(TTextKey.New('FieldTest'), TSyntaxFormat.New(TSymbolListMock.New));
  CheckEquals('FieldTest IS NULL', Condition.Syntax);
end;

procedure TIsNullSQLConditionTest.IsValidIsTrue;
var
  Condition: ISQLCondition;
begin
  Condition := TIsNullSQLCondition.New(TTextKey.New('FieldTest'), TSyntaxFormat.New(TSymbolListMock.New));
  CheckTrue(Condition.IsValid);
end;

initialization

RegisterTest(TIsNullSQLConditionTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
