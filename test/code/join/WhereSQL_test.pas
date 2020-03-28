{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit WhereSQL_test;

interface

uses
  SysUtils,
  WhereSQL,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TWhereSQLTest = class sealed(TTestCase)
  published
    procedure AndSyntaxIsAnd;
  end;

implementation

procedure TWhereSQLTest.AndSyntaxIsAnd;
begin
  CheckEquals('WHERE', TWhereSQL.New.Syntax);
end;

initialization

RegisterTest('Join', TWhereSQLTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
