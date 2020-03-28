{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit OrSQLJoin_test;

interface

uses
  SysUtils,
  OrSQLJoin,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TOrSQLJoinTest = class sealed(TTestCase)
  published
    procedure AndSyntaxIsAnd;
  end;

implementation

procedure TOrSQLJoinTest.AndSyntaxIsAnd;
begin
  CheckEquals('OR', TOrSQLJoin.New.Syntax);
end;

initialization

RegisterTest('Join', TOrSQLJoinTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
