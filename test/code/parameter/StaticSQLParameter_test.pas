{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit StaticSQLParameter_test;

interface

uses
  SQLParameter, StaticSQLParameter,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TStaticSQLParameterTest = class sealed(TTestCase)
  published
    procedure NameIsParameter1;
    procedure SyntaxIsParameter1;
    procedure IsNullIsTrue;
  end;

implementation

procedure TStaticSQLParameterTest.NameIsParameter1;
var
  Parameter: ISQLParameter;
begin
  Parameter := TStaticSQLParameter.New('Parameter1');
  CheckEquals('Parameter1', Parameter.Name);
end;

procedure TStaticSQLParameterTest.SyntaxIsParameter1;
var
  Parameter: ISQLParameter;
begin
  Parameter := TStaticSQLParameter.New('Parameter1');
  CheckEquals('Parameter1', Parameter.Syntax);
end;

procedure TStaticSQLParameterTest.IsNullIsTrue;
var
  Parameter: ISQLParameter;
begin
  Parameter := TStaticSQLParameter.New('Parameter1');
  CheckTrue(Parameter.IsNull);
end;

initialization

RegisterTest('Parameter', TStaticSQLParameterTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
