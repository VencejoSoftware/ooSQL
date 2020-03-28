{$REGION 'documentation'}
{
  Copyright (c) 2020, Vencejo Software
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
  SQLField,
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
  @member(Field @seealso(ISQLCondition.Field))
  @member(Syntax @seealso(ISQLCondition.Syntax))
  @member(IsValid @seealso(ISQLCondition.IsValid))
  @member(Parameter @seealso(ISingleSQLCondition.Parameter))
  @member(
    Create Object constructor
    @param(Field Condition field)
    @param(Comparator Comparator text)
    @param(Parameter Parameter object)
  )
  @member(
    New Create a new @classname as interface
    @param(Field Condition field)
    @param(Comparator Comparator text)
    @param(Parameter Parameter object)
  )
}
{$ENDREGION}

  TSingleSQLCondition = class sealed(TInterfacedObject, ISingleSQLCondition)
  private
    _Field: ISQLField;
    _Comparator: String;
    _Parameter: ISQLParameter;
  public
    function Field: ISQLField;
    function Syntax: String;
    function IsValid: Boolean;
    function Parameter: ISQLParameter;
    constructor Create(const Field: ISQLField; const Comparator: String; const Parameter: ISQLParameter);
    class function New(const Field: ISQLField; const Comparator: String; const Parameter: ISQLParameter)
      : ISingleSQLCondition;
  end;

implementation

function TSingleSQLCondition.Field: ISQLField;
begin
  Result := _Field;
end;

function TSingleSQLCondition.Syntax: String;
begin
  Result := _Field.Name + _Comparator + _Parameter.Value.Content;
end;

function TSingleSQLCondition.IsValid: Boolean;
begin
  Result := Assigned(_Parameter) and not _Parameter.IsNull;
end;

function TSingleSQLCondition.Parameter: ISQLParameter;
begin
  Result := _Parameter;
end;

constructor TSingleSQLCondition.Create(const Field: ISQLField; const Comparator: String;
  const Parameter: ISQLParameter);
begin
  _Field := Field;
  _Comparator := Comparator;
  _Parameter := Parameter;
end;

class function TSingleSQLCondition.New(const Field: ISQLField; const Comparator: String; const Parameter: ISQLParameter)
  : ISingleSQLCondition;
begin
  Result := TSingleSQLCondition.Create(Field, Comparator, Parameter)
end;

end.
