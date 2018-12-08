{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit DynamicSQLParameterValue_test;

interface

uses
  SysUtils,
  SQLParameterValue,
  DynamicSQLParameterValue,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TDynamicSQLParameterValueTest = class sealed(TTestCase)
  published
    procedure SyntaxReturnPrefixName1;
  end;

implementation

procedure TDynamicSQLParameterValueTest.SyntaxReturnPrefixName1;
var
  Value: ISQLParameterValue;
begin
  Value := TDynamicSQLParameterValue.New('Name1');
  CheckEquals(':Name1', Value.Syntax);
end;

initialization

RegisterTest(TDynamicSQLParameterValueTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
