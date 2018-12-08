{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL Between condition syntax object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit BetweenSQLCondition;

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
  Resolve SQL between condition as syntax. For example: [KEY_FIELD] BETWEEN [PARAMETER1] AND [PARAMETER2]
  @member(Key @seealso(ISQLCondition.Key))
  @member(Syntax @seealso(ISQLCondition.Syntax))
  @member(IsValid @seealso(ISQLCondition.IsValid))
  @member(
    Create Object constructor
    @param(Key Condition field)
    @param(Parameter1 First parameter)
    @param(Parameter2 Second parameter)
    @param(SyntaxFormat @link(ISQLJoin Syntax formatter object))
  )
  @member(
    New Create a new @classname as interface
    @param(Key Condition field)
    @param(Parameter1 First parameter)
    @param(Parameter2 Second parameter)
    @param(SyntaxFormat @link(ISQLJoin Syntax formatter object))
  )
}
{$ENDREGION}
  TBetweenSQLCondition = class sealed(TInterfacedObject, ISQLCondition)
  strict private
    _Key: ITextKey;
    _Parameter1, _Parameter2: ISQLParameter;
    _SyntaxFormat: ISyntaxFormat;
  public
    function Key: ITextKey;
    function Syntax: String;
    function IsValid: Boolean;
    constructor Create(const Key: ITextKey; const Parameter1, Parameter2: ISQLParameter;
      const SyntaxFormat: ISyntaxFormat);
    class function New(const Key: ITextKey; const Parameter1, Parameter2: ISQLParameter;
      const SyntaxFormat: ISyntaxFormat): ISQLCondition;
  end;

implementation

function TBetweenSQLCondition.Key: ITextKey;
begin
  Result := _Key;
end;

function TBetweenSQLCondition.Syntax: String;
begin
  Result := _SyntaxFormat.ItemsFormat([_Key.Value, 'BETWEEN', _Parameter1.Value.Syntax, TAndSQLJoin.New.Syntax,
    _Parameter2.Value.Syntax], [Spaced]);
end;

function TBetweenSQLCondition.IsValid: Boolean;
begin
  Result := (Assigned(_Parameter1) and not _Parameter1.IsNull);
  Result := Result and (Assigned(_Parameter2) and not _Parameter2.IsNull);
end;

constructor TBetweenSQLCondition.Create(const Key: ITextKey; const Parameter1, Parameter2: ISQLParameter;
  const SyntaxFormat: ISyntaxFormat);
begin
  _Key := Key;
  _Parameter1 := Parameter1;
  _Parameter2 := Parameter2;
  _SyntaxFormat := SyntaxFormat;
end;

class function TBetweenSQLCondition.New(const Key: ITextKey; const Parameter1, Parameter2: ISQLParameter;
  const SyntaxFormat: ISyntaxFormat): ISQLCondition;
begin
  Result := TBetweenSQLCondition.Create(Key, Parameter1, Parameter2, SyntaxFormat);
end;

end.
