{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL less or equal condition syntax object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit LessOrEqualSQLCondition;

interface

uses
  Key,
  SyntaxFormat,
  SQLParameter,
  SQLCondition,
  SingleSQLCondition;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ISQLCondition))
  Resolve SQL less or equal condition as syntax. For example: [KEY_FIELD] <= [PARAMETER1]
  @member(Key @seealso(ISQLCondition.Key))
  @member(Syntax @seealso(ISQLCondition.Syntax))
  @member(IsValid @seealso(ISQLCondition.IsValid))
  @member(
    Create Object constructor
    @param(Key Condition field)
    @param(Parameter Parameter object)
    @param(SyntaxFormat @link(ISQLJoin Syntax formatter object))
  )
  @member(
    New Create a new @classname as interface
    @param(Key Condition field)
    @param(Parameter Parameter object)
    @param(SyntaxFormat @link(ISQLJoin Syntax formatter object))
  )
}
{$ENDREGION}
  TLessOrEqualSQLCondition = class sealed(TInterfacedObject, ISQLCondition, ISingleSQLCondition)
  private
    _Condition: ISingleSQLCondition;
  public
    function Key: ITextKey;
    function Syntax: String;
    function IsValid: Boolean;
    function Parameter: ISQLParameter;
    constructor Create(const Key: ITextKey; const Parameter: ISQLParameter; const SyntaxFormat: ISyntaxFormat);
    class function New(const Key: ITextKey; const Parameter: ISQLParameter; const SyntaxFormat: ISyntaxFormat)
      : ISingleSQLCondition;
  end;

implementation

function TLessOrEqualSQLCondition.Key: ITextKey;
begin
  Result := _Condition.Key;
end;

function TLessOrEqualSQLCondition.Syntax: String;
begin
  Result := _Condition.Syntax;
end;

function TLessOrEqualSQLCondition.IsValid: Boolean;
begin
  Result := _Condition.IsValid;
end;

function TLessOrEqualSQLCondition.Parameter: ISQLParameter;
begin
  Result := _Condition.Parameter;
end;

constructor TLessOrEqualSQLCondition.Create(const Key: ITextKey; const Parameter: ISQLParameter;
  const SyntaxFormat: ISyntaxFormat);
begin
  _Condition := TSingleSQLCondition.New(Key, '<=', Parameter, SyntaxFormat);
end;

class function TLessOrEqualSQLCondition.New(const Key: ITextKey; const Parameter: ISQLParameter;
  const SyntaxFormat: ISyntaxFormat): ISingleSQLCondition;
begin
  Result := TLessOrEqualSQLCondition.Create(Key, Parameter, SyntaxFormat);
end;

end.
