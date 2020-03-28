{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit SQLParameterValue_test;

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
  TSQLParameterValueTest = class sealed(TTestCase)
  published
    procedure ContentIsValueGeneral;
    procedure ValueIsValueGeneral;
  end;

implementation

procedure TSQLParameterValueTest.ContentIsValueGeneral;
var
  Value: ISQLParameterValue;
begin
  Value := TSQLParameterValue.New('Value general');
  CheckEquals('Value general', Value.Content);
end;

procedure TSQLParameterValueTest.ValueIsValueGeneral;
var
  Value: ISQLParameterValue;
begin
  Value := TSQLParameterValue.New('Value general');
  CheckEquals('Value general', Value.Content);
end;

initialization

RegisterTest('Parameter', TSQLParameterValueTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
