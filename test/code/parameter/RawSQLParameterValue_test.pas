{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit RawSQLParameterValue_test;

interface

uses
  SysUtils,
  SQLParameterValue,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TRawSQLParameterValueTest = class sealed(TTestCase)
  published
    procedure SyntaxIsValueGeneral;
    procedure ValueIsValueGeneral;
  end;

implementation

procedure TRawSQLParameterValueTest.SyntaxIsValueGeneral;
var
  Value: IRawSQLParameterValue;
begin
  Value := TRawSQLParameterValue.New('Value general');
  CheckEquals('Value general', Value.Syntax);
end;

procedure TRawSQLParameterValueTest.ValueIsValueGeneral;
var
  Value: IRawSQLParameterValue;
begin
  Value := TRawSQLParameterValue.New('Value general');
  CheckEquals('Value general', Value.Content);
end;

initialization

RegisterTest(TRawSQLParameterValueTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
