{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Single SQL condition syntax object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit SingleSQLCondition;

interface

uses
  Key,
  SyntaxFormat,
  SQLParameter,
  SQLCondition;

type
{$REGION 'documentation'}
{
  @abstract(SQL condition object)
  Object to resolve a single parameter SQL condition syntax
  @member(
    Parameter Parameter object
    @return(@link(ISQLParameter Parameter object))
  )
}
{$ENDREGION}
  ISingleSQLCondition = interface(ISQLCondition)
    ['{065C66EA-B1B2-4E91-A72E-1CEEEADF17FD}']
    function Parameter: ISQLParameter;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ISingleSQLCondition))
  @member(Key @seealso(ISQLCondition.Key))
  @member(Syntax @seealso(ISQLCondition.Syntax))
  @member(IsValid @seealso(ISQLCondition.IsValid))
  @member(Parameter @seealso(ISingleSQLCondition.Parameter))
  @member(
    Create Object constructor
    @param(Key Condition field)
    @param(Comparator Comparator text)
    @param(Parameter Parameter object)
    @param(SyntaxFormat @link(ISQLJoin Syntax formatter object))
  )
  @member(
    New Create a new @classname as interface
    @param(Key Condition field)
    @param(Comparator Comparator text)
    @param(Parameter Parameter object)
    @param(SyntaxFormat @link(ISQLJoin Syntax formatter object))
  )
}
{$ENDREGION}

  TSingleSQLCondition = class sealed(TInterfacedObject, ISingleSQLCondition)
  private
    _Key: ITextKey;
    _Comparator: String;
    _Parameter: ISQLParameter;
    _SyntaxFormat: ISyntaxFormat;
  public
    function Key: ITextKey;
    function Syntax: String;
    function IsValid: Boolean;
    function Parameter: ISQLParameter;
    constructor Create(const Key: ITextKey; const Comparator: String; const Parameter: ISQLParameter;
      const SyntaxFormat: ISyntaxFormat);
    class function New(const Key: ITextKey; const Comparator: String; const Parameter: ISQLParameter;
      const SyntaxFormat: ISyntaxFormat): ISingleSQLCondition;
  end;

implementation

function TSingleSQLCondition.Key: ITextKey;
begin
  Result := _Key;
end;

function TSingleSQLCondition.Syntax: String;
begin
  Result := _SyntaxFormat.ItemsFormat([_Key.Value, _Comparator, _Parameter.Value.Syntax], [Spaced]);
end;

function TSingleSQLCondition.IsValid: Boolean;
begin
  Result := Assigned(_Parameter) and not _Parameter.IsNull;
end;

function TSingleSQLCondition.Parameter: ISQLParameter;
begin
  Result := _Parameter;
end;

constructor TSingleSQLCondition.Create(const Key: ITextKey; const Comparator: String; const Parameter: ISQLParameter;
  const SyntaxFormat: ISyntaxFormat);
begin
  _Key := Key;
  _Comparator := Comparator;
  _Parameter := Parameter;
  _SyntaxFormat := SyntaxFormat;
end;

class function TSingleSQLCondition.New(const Key: ITextKey; const Comparator: String; const Parameter: ISQLParameter;
  const SyntaxFormat: ISyntaxFormat): ISingleSQLCondition;
begin
  Result := TSingleSQLCondition.Create(Key, Comparator, Parameter, SyntaxFormat)
end;

end.
