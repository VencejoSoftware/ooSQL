{$REGION 'documentation'}
{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Join SQL condition objects
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit JoinedSQLCondition;

interface

uses
  SQLField,
  Statement,
  SQLJoin,
  SQLCondition;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ISQLCondition))
  Resolve SQL join condition as syntax. For example: [JOIN] ([CONDITION])
  @member(Field @seealso(ISQLCondition.Field))
  @member(Syntax @seealso(ISQLCondition.Syntax))
  @member(IsValid @seealso(ISQLCondition.IsValid))
  @member(
    PlainParameters Parse parameters syntax as simple text
    @return(Text with syntax parameters)
  )
  @member(
    Create Object constructor
    @param(Join Join syntax object)
    @param(Condition Condition syntax object)
  )
  @member(
    New Create a new @classname as interface
    @param(Join Join syntax object)
    @param(Condition Condition syntax object)
  )
}
{$ENDREGION}
  TJoinedSQLCondition = class sealed(TInterfacedObject, ISQLCondition)
  strict private
    _Join: ISQLJoin;
    _Condition: ISQLCondition;
  public
    function Field: ISQLField;
    function Syntax: String;
    function IsValid: Boolean;
    constructor Create(const Join: ISQLJoin; const Condition: ISQLCondition);
    class function New(const Join: ISQLJoin; const Condition: ISQLCondition): ISQLCondition;
  end;

implementation

function TJoinedSQLCondition.Field: ISQLField;
begin
  Result := _Condition.Field;
end;

function TJoinedSQLCondition.Syntax: String;
begin
  Result := _Join.Syntax;
  if Length(Result) > 0 then
    Result := Result + ' ';
  Result := Result + '(' + _Condition.Syntax + ')';
end;

function TJoinedSQLCondition.IsValid: Boolean;
begin
  Result := _Condition.IsValid;
end;

constructor TJoinedSQLCondition.Create(const Join: ISQLJoin; const Condition: ISQLCondition);
begin
  _Join := Join;
  _Condition := Condition;
end;

class function TJoinedSQLCondition.New(const Join: ISQLJoin; const Condition: ISQLCondition): ISQLCondition;
begin
  Result := TJoinedSQLCondition.Create(Join, Condition);
end;

end.
