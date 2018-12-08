{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit NoneSQLJoin_test;

interface

uses
  SysUtils,
  NoneSQLJoin,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TNoneSQLJoinTest = class sealed(TTestCase)
  published
    procedure AndSyntaxIsAnd;
  end;

implementation

procedure TNoneSQLJoinTest.AndSyntaxIsAnd;
begin
  CheckEquals(EmptyStr, TNoneSQLJoin.New.Syntax);
end;

initialization

RegisterTest(TNoneSQLJoinTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
