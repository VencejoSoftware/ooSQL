{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit UIntegerSQLParameterValue_test;

interface

uses
  SysUtils,
  SQLParameterValue,
  UIntegerSQLParameterValue,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TUIntegerSQLParameterValueTest = class sealed(TTestCase)
  published
    procedure TenReturnSyntax10;
    procedure TenReturnContent10;
  end;

implementation

procedure TUIntegerSQLParameterValueTest.TenReturnSyntax10;
var
  Value: IUIntegerSQLParameterValue;
begin
  Value := TUIntegerSQLParameterValue.New(10);
  CheckEquals('10', Value.Syntax);
end;

procedure TUIntegerSQLParameterValueTest.TenReturnContent10;
var
  Value: IUIntegerSQLParameterValue;
begin
  Value := TUIntegerSQLParameterValue.New(10);
  CheckEquals(10, Value.Content);
end;

initialization

RegisterTest(TUIntegerSQLParameterValueTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
