{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
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
  Key,
  Statement,
  SyntaxFormat,
  SQLJoin,
  SQLCondition;

type
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ISQLCondition))
  Resolve SQL join condition as syntax. For example: [JOIN] ([CONDITION])
  @member(Key @seealso(ISQLCondition.Key))
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
    @param(SyntaxFormat @link(ISQLJoin Syntax formatter object))
  )
  @member(
    New Create a new @classname as interface
    @param(Join Join syntax object)
    @param(Condition Condition syntax object)
    @param(SyntaxFormat @link(ISQLJoin Syntax formatter object))
  )
}
{$ENDREGION}
  TJoinedSQLCondition = class sealed(TInterfacedObject, ISQLCondition)
  strict private
    _SyntaxFormat: ISyntaxFormat;
    _Join: ISQLJoin;
    _Condition: ISQLCondition;
  public
    function Key: ITextKey;
    function Syntax: String;
    function IsValid: Boolean;
    constructor Create(const Join: ISQLJoin; const Condition: ISQLCondition; const SyntaxFormat: ISyntaxFormat);
    class function New(const Join: ISQLJoin; const Condition: ISQLCondition; const SyntaxFormat: ISyntaxFormat)
      : ISQLCondition;
  end;

implementation

function TJoinedSQLCondition.Key: ITextKey;
begin
  Result := _Condition.Key;
end;

function TJoinedSQLCondition.Syntax: String;
begin
  Result := _SyntaxFormat.ItemsFormat([_Join.Syntax, _SyntaxFormat.TextFormat(_Condition.Syntax, [Enclosed])],
    [Spaced]);
end;

function TJoinedSQLCondition.IsValid: Boolean;
begin
  Result := _Condition.IsValid;
end;

constructor TJoinedSQLCondition.Create(const Join: ISQLJoin; const Condition: ISQLCondition;
  const SyntaxFormat: ISyntaxFormat);
begin
  _SyntaxFormat := SyntaxFormat;
  _Join := Join;
  _Condition := Condition;
end;

class function TJoinedSQLCondition.New(const Join: ISQLJoin; const Condition: ISQLCondition;
  const SyntaxFormat: ISyntaxFormat): ISQLCondition;
begin
  Result := TJoinedSQLCondition.Create(Join, Condition, SyntaxFormat);
end;

end.
