{$REGION 'documentation'}
{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Raw SQL condition object
  @created(23/03/2020)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit RawSQLCondition;

interface

uses
  SQLField,
  SQLCondition;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ISQLCondition))
  Use a raw customized text to resolve SQL condition object
  @member(Field @seealso(ISQLCondition.Field))
  @member(Syntax @seealso(ISQLCondition.Syntax))
  @member(IsValid @seealso(ISQLCondition.IsValid))
  @member(
    Create Object constructor
    @param(Syntax Text with the condition syntax)
  )
  @member(
    New Create a new @classname as interface
    @param(Syntax Text with the condition syntax)
  )
}
{$ENDREGION}
  TRawSQLCondition = class sealed(TInterfacedObject, ISQLCondition)
  strict private
    _Syntax: String;
  public
    function Syntax: String;
    function Field: ISQLField;
    function IsValid: Boolean;
    constructor Create(const Syntax: String);
    class function New(const Syntax: String): ISQLCondition;
  end;

implementation

function TRawSQLCondition.Syntax: String;
begin
  Result := _Syntax;
end;

function TRawSQLCondition.Field: ISQLField;
begin
  Result := nil;
end;

function TRawSQLCondition.IsValid: Boolean;
begin
  Result := True;
end;

constructor TRawSQLCondition.Create(const Syntax: String);
begin
  _Syntax := Syntax;
end;

class function TRawSQLCondition.New(const Syntax: String): ISQLCondition;
begin
  Result := TRawSQLCondition.Create(Syntax);
end;

end.
