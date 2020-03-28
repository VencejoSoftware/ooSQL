{$REGION 'documentation'}
{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL greater or equal condition syntax object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit GreaterOrEqualSQLCondition;

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
  Resolve SQL greater or equal condition as syntax. For example: [FIELD] >= [PARAMETER]
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
  TGreaterOrEqualSQLCondition = class sealed(TInterfacedObject, ISQLCondition, ISingleSQLCondition)
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

function TGreaterOrEqualSQLCondition.Field: ISQLField;
begin
  Result := _Condition.Field;
end;

function TGreaterOrEqualSQLCondition.Syntax: String;
begin
  Result := _Condition.Syntax;
end;

function TGreaterOrEqualSQLCondition.IsValid: Boolean;
begin
  Result := _Condition.IsValid;
end;

function TGreaterOrEqualSQLCondition.Parameter: ISQLParameter;
begin
  Result := _Condition.Parameter;
end;

constructor TGreaterOrEqualSQLCondition.Create(const Field: ISQLField; const Parameter: ISQLParameter);
begin
  _Condition := TSingleSQLCondition.New(Field, '>=', Parameter);
end;

class function TGreaterOrEqualSQLCondition.New(const Field: ISQLField; const Parameter: ISQLParameter)
  : ISingleSQLCondition;
begin
  Result := TGreaterOrEqualSQLCondition.Create(Field, Parameter);
end;

end.
