{$REGION 'documentation'}
{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Mutable parameter object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit MutableSQLParameter;

interface

uses
  SysUtils,
  IterableList,
  SQLParameter,
  SQLParameterValue, ReplaceableSQLParameterValue;

type
{$REGION 'documentation'}
{
  @abstract(SQL mutable parameter object)
  Object to resolve a SQL parameter syntax, with change value capabilities
  @member(
    ChangeValue Change the current parameter value object
    @param(@link(ISQLParameterValue Parameter value object))
  )
  @member(
    Clear Set value in nil
  )
}
{$ENDREGION}
  IMutableSQLParameter = interface(ISQLParameter)
    ['{F6784B28-AC2D-4977-8BD1-85A7F58AE136}']
    procedure ChangeValue(const Value: ISQLParameterValue);
    procedure Clear;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ISQLParameter))
  @member(Syntax @seealso(IStatement.Syntax))
  @member(Name @seealso(ISQLParameter.Name))
  @member(Value @seealso(ISQLParameter.Value))
  @member(IsNull @seealso(ISQLParameter.IsNull))
  @member(ChangeValue @seealso(IMutableSQLParameter.ChangeValue))
  @member(Clear @seealso(IMutableSQLParameter.Clear))
  @member(
    Create Object constructor
    @param(Name Parameter name)
  )
  @member(
    New Create a new @classname as interface
    @param(Name Parameter name)
    @param(UsePrefix @true defines simple parameter mode [:VALUE] or @false the enclosed mode [#123VALUE#125])
  )
  @member(
    NewWithOutName Create a new @classname as interface without a specific name
    @param(UsePrefix @true defines simple parameter mode [:VALUE] or @false the enclosed mode [#123VALUE#125])
  )
}
{$ENDREGION}

  TMutableSQLParameter = class sealed(TInterfacedObject, IMutableSQLParameter)
  strict private
    _Name, _Syntax: String;
    _Value: ISQLParameterValue;
  public
    function Name: String;
    function Syntax: String;
    function Value: ISQLParameterValue;
    function IsNull: Boolean;
    procedure ChangeValue(const Value: ISQLParameterValue);
    procedure Clear;
    constructor Create(const Name: String; const UsePrefix: Boolean);
    class function New(const Name: String; const UsePrefix: Boolean = True): IMutableSQLParameter;
    class function NewWithOutName(const UsePrefix: Boolean = True): IMutableSQLParameter;
  end;

{$REGION 'documentation'}
{
  @abstract(SQL parameter list object)
  List of parameters
}
{$ENDREGION}

  IMutableSQLParameterList = interface(IIterableList<IMutableSQLParameter>)
    ['{9EC80759-A699-4AAA-9BF5-80F7ED186B94}']
    function SQLParameterList: ISQLParameterList;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IMutableSQLParameterList))
  @member(
    New Create a new @classname as interface
  )
}
{$ENDREGION}

  TMutableSQLParameterList = class sealed(TIterableList<IMutableSQLParameter>, IMutableSQLParameterList)
  public
    function SQLParameterList: ISQLParameterList;
    class function New: IMutableSQLParameterList;
  end;

implementation

function TMutableSQLParameter.Name: String;
begin
  Result := _Name;
end;

function TMutableSQLParameter.Syntax: String;
begin
  Result := _Syntax;
end;

function TMutableSQLParameter.Value: ISQLParameterValue;
begin
  Result := _Value;
end;

function TMutableSQLParameter.IsNull: Boolean;
begin
  Result := not Assigned(_Value);
end;

procedure TMutableSQLParameter.ChangeValue(const Value: ISQLParameterValue);
begin
  _Value := Value;
end;

procedure TMutableSQLParameter.Clear;
begin
  ChangeValue(nil);
end;

constructor TMutableSQLParameter.Create(const Name: String; const UsePrefix: Boolean);
begin
  _Name := Name;
  _Syntax := TReplaceableSQLParameterValue.New(Name, UsePrefix).Content;
end;

class function TMutableSQLParameter.New(const Name: String; const UsePrefix: Boolean): IMutableSQLParameter;
begin
  Result := TMutableSQLParameter.Create(Name, UsePrefix);
end;

class function TMutableSQLParameter.NewWithOutName(const UsePrefix: Boolean): IMutableSQLParameter;
begin
  Result := TMutableSQLParameter.New(EmptyStr, UsePrefix);
end;

{ TMutableSQLParameterList }

function TMutableSQLParameterList.SQLParameterList: ISQLParameterList;
var
  Item: IMutableSQLParameter;
begin
  Result := TSQLParameterList.New;
  for Item in Self do
    Result.Add(Item);
end;

class function TMutableSQLParameterList.New: IMutableSQLParameterList;
begin
  Result := TMutableSQLParameterList.Create;
end;

end.
