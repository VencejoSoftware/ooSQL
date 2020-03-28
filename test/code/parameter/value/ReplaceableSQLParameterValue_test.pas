{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ReplaceableSQLParameterValue_test;

interface

uses
  SysUtils,
  SQLParameterValue,
  ReplaceableSQLParameterValue,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TReplaceableSQLParameterValueTest = class sealed(TTestCase)
  published
    procedure ContentReturnPrefixName1;
    procedure ContentEnclosedIsEncloseStartName1EncloseEnd;
  end;

implementation

procedure TReplaceableSQLParameterValueTest.ContentReturnPrefixName1;
var
  Value: ISQLParameterValue;
begin
  Value := TReplaceableSQLParameterValue.New('Name1');
  CheckEquals(':Name1', Value.Content);
end;

procedure TReplaceableSQLParameterValueTest.ContentEnclosedIsEncloseStartName1EncloseEnd;
var
  Parameter: ISQLParameterValue;
begin
  Parameter := TReplaceableSQLParameterValue.New('Name1', False);
  CheckEquals('{Name1}', Parameter.Content);
end;

initialization

RegisterTest('Parameter', TReplaceableSQLParameterValueTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
