{$REGION 'documentation'}
{
  Copyright (c) 2020, Vencejo Software
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
  SQLField,
  SQLParameter,
  SQLCondition;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ISQLCondition))
  Resolve SQL between condition as syntax. For example: [FIELD] BETWEEN [PARAMETER1] AND [PARAMETER2]
  @member(Field @seealso(ISQLCondition.Field))
  @member(Syntax @seealso(ISQLCondition.Syntax))
  @member(IsValid @seealso(ISQLCondition.IsValid))
  @member(
    Create Object constructor
    @param(Field Condition field)
    @param(Parameter1 First parameter)
    @param(Parameter2 Second parameter)
  )
  @member(
    New Create a new @classname as interface
    @param(Field Condition field)
    @param(Parameter1 First parameter)
    @param(Parameter2 Second parameter)
  )
}
{$ENDREGION}
  TBetweenSQLCondition = class sealed(TInterfacedObject, ISQLCondition)
  strict private
    _Field: ISQLField;
    _Parameter1, _Parameter2: ISQLParameter;
  public
    function Field: ISQLField;
    function Syntax: String;
    function IsValid: Boolean;
    constructor Create(const Field: ISQLField; const Parameter1, Parameter2: ISQLParameter);
    class function New(const Field: ISQLField; const Parameter1, Parameter2: ISQLParameter): ISQLCondition;
  end;

implementation

function TBetweenSQLCondition.Field: ISQLField;
begin
  Result := _Field;
end;

function TBetweenSQLCondition.Syntax: String;
begin
  Result := _Field.Name + ' BETWEEN ' + _Parameter1.Value.Content + ' AND ' + _Parameter2.Value.Content;
end;

function TBetweenSQLCondition.IsValid: Boolean;
begin
  Result := (Assigned(_Parameter1) and not _Parameter1.IsNull);
  Result := Result and (Assigned(_Parameter2) and not _Parameter2.IsNull);
end;

constructor TBetweenSQLCondition.Create(const Field: ISQLField; const Parameter1, Parameter2: ISQLParameter);
begin
  _Field := Field;
  _Parameter1 := Parameter1;
  _Parameter2 := Parameter2;
end;

class function TBetweenSQLCondition.New(const Field: ISQLField; const Parameter1, Parameter2: ISQLParameter)
  : ISQLCondition;
begin
  Result := TBetweenSQLCondition.Create(Field, Parameter1, Parameter2);
end;

end.
