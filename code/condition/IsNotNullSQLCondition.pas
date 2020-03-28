{$REGION 'documentation'}
{
  Copyright (c) 2020, Vencejo Software
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
  SQLField,
  SQLCondition;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ISQLCondition))
  Resolve SQL is not null condition as syntax. For example: [FIELD] IS NOT NULL
  @member(Field @seealso(ISQLCondition.Field))
  @member(Syntax @seealso(ISQLCondition.Syntax))
  @member(IsValid @seealso(ISQLCondition.IsValid))
  @member(
    Create Object constructor
    @param(Field Condition field)
  )
  @member(
    New Create a new @classname as interface
    @param(Field Condition field)
  )
}
{$ENDREGION}
  TIsNotNullSQLCondition = class sealed(TInterfacedObject, ISQLCondition)
  private
    _Field: ISQLField;
  public
    function Field: ISQLField;
    function Syntax: String;
    function IsValid: Boolean;
    constructor Create(const Field: ISQLField);
    class function New(const Field: ISQLField): ISQLCondition;
  end;

implementation

function TIsNotNullSQLCondition.Field: ISQLField;
begin
  Result := _Field;
end;

function TIsNotNullSQLCondition.Syntax: String;
begin
  Result := _Field.Name + ' IS NOT NULL';
end;

function TIsNotNullSQLCondition.IsValid: Boolean;
begin
  Result := True;
end;

constructor TIsNotNullSQLCondition.Create(const Field: ISQLField);
begin
  _Field := Field;
end;

class function TIsNotNullSQLCondition.New(const Field: ISQLField): ISQLCondition;
begin
  Result := TIsNotNullSQLCondition.Create(Field);
end;

end.
