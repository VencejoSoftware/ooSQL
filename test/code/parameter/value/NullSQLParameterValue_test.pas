{
  Copyright (c) 2020, Vencejo Software
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
    procedure ContentIsNULL;
  end;

implementation

procedure TNullSQLParameterValueTest.ContentIsNULL;
var
  Value: ISQLParameterValue;
begin
  Value := TNullSQLParameterValue.New;
  CheckEquals('NULL', Value.Content);
end;

initialization

RegisterTest('Parameter', TNullSQLParameterValueTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
