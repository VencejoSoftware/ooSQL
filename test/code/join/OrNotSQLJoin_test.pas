{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit OrNotSQLJoin_test;

interface

uses
  SysUtils,
  OrNotSQLJoin,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TOrNotSQLJoinTest = class sealed(TTestCase)
  published
    procedure AndSyntaxIsAnd;
  end;

implementation

procedure TOrNotSQLJoinTest.AndSyntaxIsAnd;
begin
  CheckEquals('OR NOT', TOrNotSQLJoin.New.Syntax);
end;

initialization

RegisterTest(TOrNotSQLJoinTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
