{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit AndNotSQLJoin_test;

interface

uses
  SysUtils,
  AndNotSQLJoin,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TAndNotSQLJoinTest = class sealed(TTestCase)
  published
    procedure AndSyntaxIsAnd;
  end;

implementation

procedure TAndNotSQLJoinTest.AndSyntaxIsAnd;
begin
  CheckEquals('AND NOT', TAndNotSQLJoin.New.Syntax);
end;

initialization

RegisterTest(TAndNotSQLJoinTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
