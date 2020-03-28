{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit RawSQLCondition_test;

interface

uses
  SysUtils,
  RawSQLCondition,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TRawSQLConditionTest = class sealed(TTestCase)
  published
    procedure FieldIsNil;
    procedure SyntaxIsFieldCustom666;
    procedure IsValidIsTrue;
  end;

implementation

procedure TRawSQLConditionTest.FieldIsNil;
begin
  CheckFalse(Assigned(TRawSQLCondition.New('FIELD CUSTOM 666').Field));
end;

procedure TRawSQLConditionTest.SyntaxIsFieldCustom666;
begin
  CheckEquals('FIELD CUSTOM 666', TRawSQLCondition.New('FIELD CUSTOM 666').Syntax);
end;

procedure TRawSQLConditionTest.IsValidIsTrue;
begin
  CheckTrue(TRawSQLCondition.New('FIELD CUSTOM 666').IsValid);
end;

initialization

RegisterTest('Filter condition', TRawSQLConditionTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
