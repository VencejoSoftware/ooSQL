{$REGION 'documentation'}
{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL equal condition syntax object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit EqualSQLCondition;

interface

uses
  SQLField,
  SQLParameter,
  SQLCondition,
  SingleSQLCondition;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ISQLCondition))
  Resolve SQL equal condition as syntax. For example: [FIELD] = [PARAMETER]
  @member(Field @seealso(ISQLCondition.Field))
  @member(Syntax @seealso(ISQLCondition.Syntax))
  @member(IsValid @seealso(ISQLCondition.IsValid))
  @member(
    Create Object constructor
    @param(Field Condition field)
    @param(Parameter Parameter object)
  )
  @member(
    New Create a new @classname as interface
    @param(Field Condition field)
    @param(Parameter Parameter object)
  )
}
{$ENDREGION}
  TEqualSQLCondition = class sealed(TInterfacedObject, ISQLCondition, ISingleSQLCondition)
  private
    _Condition: ISingleSQLCondition;
  public
    function Field: ISQLField;
    function Syntax: String;
    function IsValid: Boolean;
    function Parameter: ISQLParameter;
    constructor Create(const Field: ISQLField; const Parameter: ISQLParameter);
    class function New(const Field: ISQLField; const Parameter: ISQLParameter): ISingleSQLCondition;
  end;

implementation

function TEqualSQLCondition.Field: ISQLField;
begin
  Result := _Condition.Field;
end;

function TEqualSQLCondition.Syntax: String;
begin
  Result := _Condition.Syntax;
end;

function TEqualSQLCondition.IsValid: Boolean;
begin
  Result := _Condition.IsValid;
end;

function TEqualSQLCondition.Parameter: ISQLParameter;
begin
  Result := _Condition.Parameter;
end;

constructor TEqualSQLCondition.Create(const Field: ISQLField; const Parameter: ISQLParameter);
begin
  _Condition := TSingleSQLCondition.New(Field, '=', Parameter);
end;

class function TEqualSQLCondition.New(const Field: ISQLField; const Parameter: ISQLParameter): ISingleSQLCondition;
begin
  Result := TEqualSQLCondition.Create(Field, Parameter);
end;

end.
