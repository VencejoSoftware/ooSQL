{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL is not null condition syntax object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit IsNotNullSQLCondition;

interface

uses
  Key,
  SyntaxFormat,
  SQLCondition;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ISQLCondition))
  Resolve SQL is not null condition as syntax. For example: [KEY_FIELD] IS NOT NULL
  @member(Key @seealso(ISQLCondition.Key))
  @member(Syntax @seealso(ISQLCondition.Syntax))
  @member(IsValid @seealso(ISQLCondition.IsValid))
  @member(
    Create Object constructor
    @param(Key Condition field)
    @param(SyntaxFormat @link(ISQLJoin Syntax formatter object))
  )
  @member(
    New Create a new @classname as interface
    @param(Key Condition field)
    @param(SyntaxFormat @link(ISQLJoin Syntax formatter object))
  )
}
{$ENDREGION}
  TIsNotNullSQLCondition = class sealed(TInterfacedObject, ISQLCondition)
  private
    _Key: ITextKey;
    _SyntaxFormat: ISyntaxFormat;
  public
    function Key: ITextKey;
    function Syntax: String;
    function IsValid: Boolean;
    constructor Create(const Key: ITextKey; const SyntaxFormat: ISyntaxFormat);
    class function New(const Key: ITextKey; const SyntaxFormat: ISyntaxFormat): ISQLCondition;
  end;

implementation

function TIsNotNullSQLCondition.Key: ITextKey;
begin
  Result := _Key;
end;

function TIsNotNullSQLCondition.Syntax: String;
begin
  Result := _SyntaxFormat.ItemsFormat([_Key.Value, 'IS NOT NULL'], [Spaced]);
end;

function TIsNotNullSQLCondition.IsValid: Boolean;
begin
  Result := True;
end;

constructor TIsNotNullSQLCondition.Create(const Key: ITextKey; const SyntaxFormat: ISyntaxFormat);
begin
  _Key := Key;
  _SyntaxFormat := SyntaxFormat;
end;

class function TIsNotNullSQLCondition.New(const Key: ITextKey; const SyntaxFormat: ISyntaxFormat): ISQLCondition;
begin
  Result := TIsNotNullSQLCondition.Create(Key, SyntaxFormat);
end;

end.
