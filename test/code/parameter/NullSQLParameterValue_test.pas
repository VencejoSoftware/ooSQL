{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit NullSQLParameterValue_test;

interface

uses
  SysUtils,
  SQLParameterValue,
  NullSQLParameterValue,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TNullSQLParameterValueTest = class sealed(TTestCase)
  published
    procedure SyntaxIsNULL;
  end;

implementation

procedure TNullSQLParameterValueTest.SyntaxIsNULL;
var
  Value: ISQLParameterValue;
begin
  Value := TNullSQLParameterValue.New;
  CheckEquals('NULL', Value.Syntax);
end;

initialization

RegisterTest(TNullSQLParameterValueTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
