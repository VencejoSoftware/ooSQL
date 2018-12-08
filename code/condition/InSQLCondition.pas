{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL IN condition syntax object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit InSQLCondition;

interface

uses
  SysUtils,
  Key,
  SyntaxFormat,
  AndSQLJoin,
  SQLParameter,
  SQLCondition;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ISQLCondition))
  Resolve SQL IN condition as syntax. For example: [KEY_FIELD] IN ([PARAMETER1]..[PARAMETERN])
  @member(Key @seealso(ISQLCondition.Key))
  @member(Syntax @seealso(ISQLCondition.Syntax))
  @member(
    Validate all paramters and exit if one is false
    IsValid @seealso(ISQLCondition.IsValid)
  )
  @member(
    PlainParameters Parse parameters syntax as simple text
    @return(Text with syntax parameters)
  )
  @member(
    Create Object constructor
    @param(Key Condition field)
    @param(Parameters Array of parameter object)
    @param(SyntaxFormat @link(ISQLJoin Syntax formatter object))
  )
  @member(
    New Create a new @classname as interface
    @param(Key Condition field)
    @param(Parameters Array of parameter object)
    @param(SyntaxFormat @link(ISQLJoin Syntax formatter object))
  )
}
{$ENDREGION}
  TInSQLCondition = class sealed(TInterfacedObject, ISQLCondition)
  strict private
    _Key: ITextKey;
    _Parameters: Array of ISQLParameter;
    _SyntaxFormat: ISyntaxFormat;
  private
    function PlainParameters: String;
  public
    function Key: ITextKey;
    function Syntax: String;
    function IsValid: Boolean;
    constructor Create(const Key: ITextKey; const Parameters: Array of ISQLParameter;
      const SyntaxFormat: ISyntaxFormat);
    class function New(const Key: ITextKey; const Parameters: Array of ISQLParameter; const SyntaxFormat: ISyntaxFormat)
      : ISQLCondition;
  end;

implementation

function TInSQLCondition.Key: ITextKey;
begin
  Result := _Key;
end;

function TInSQLCondition.PlainParameters: String;
var
  Item: ISQLParameter;
begin
  Result := EmptyStr;
  for Item in _Parameters do
    Result := Result + Item.Value.Syntax + ', ';
  Result := '(' + Copy(Result, 1, Length(Result) - 2) + ')';
end;

function TInSQLCondition.Syntax: String;
begin
  Result := _SyntaxFormat.ItemsFormat([_Key.Value, 'IN', PlainParameters], [Spaced]);
end;

function TInSQLCondition.IsValid: Boolean;
var
  Item: ISQLParameter;
begin
  Result := False;
  for Item in _Parameters do
  begin
    Result := Assigned(Item) and not Item.IsNull;
    if not Result then
      Exit(False);
  end;
end;

constructor TInSQLCondition.Create(const Key: ITextKey; const Parameters: Array of ISQLParameter;
  const SyntaxFormat: ISyntaxFormat);
var
  i: Integer;
begin
  _Key := Key;
  _SyntaxFormat := SyntaxFormat;
  SetLength(_Parameters, Length(Parameters));
  for i := 0 to High(Parameters) do
    _Parameters[i] := Parameters[i];
end;

class function TInSQLCondition.New(const Key: ITextKey; const Parameters: Array of ISQLParameter;
  const SyntaxFormat: ISyntaxFormat): ISQLCondition;
begin
  Result := TInSQLCondition.Create(Key, Parameters, SyntaxFormat);
end;

end.
