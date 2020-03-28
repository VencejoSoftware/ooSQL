{$REGION 'documentation'}
{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL is null condition syntax object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit IsNullSQLCondition;

interface

uses
  SQLField,
  SQLCondition;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ISQLCondition))
  Resolve SQL is null condition as syntax. For example: [FIELD] IS NULL
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
  TIsNullSQLCondition = class sealed(TInterfacedObject, ISQLCondition)
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

function TIsNullSQLCondition.Field: ISQLField;
begin
  Result := _Field;
end;

function TIsNullSQLCondition.Syntax: String;
begin
  Result := _Field.Name + ' IS NULL';
end;

function TIsNullSQLCondition.IsValid: Boolean;
begin
  Result := True;
end;

constructor TIsNullSQLCondition.Create(const Field: ISQLField);
begin
  _Field := Field;
end;

class function TIsNullSQLCondition.New(const Field: ISQLField): ISQLCondition;
begin
  Result := TIsNullSQLCondition.Create(Field);
end;

end.
