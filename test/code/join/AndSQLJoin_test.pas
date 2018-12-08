{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit AndSQLJoin_test;

interface

uses
  SysUtils,
  AndSQLJoin,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TAndSQLJoinTest = class sealed(TTestCase)
  published
    procedure AndSyntaxIsAnd;
  end;

implementation

procedure TAndSQLJoinTest.AndSyntaxIsAnd;
begin
  CheckEquals('AND', TAndSQLJoin.New.Syntax);
end;

initialization

RegisterTest(TAndSQLJoinTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
