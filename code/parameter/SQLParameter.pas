{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  SQL parameter syntax object
  @created(21/12/2017)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit SQLParameter;

interface

uses
  SysUtils,
  Statement,
  SQLParameterValue,
  IterableList;

type
{$REGION 'documentation'}
{
  @abstract(SQL parameter syntax object)
  Object to resolve a SQL parameter syntax
  @member(
    Name Parameter name
    @return(Text with parameter name)
  )
  @member(
    Value Parameter value object
    @return(@link(ISQLParameterValue Parameter value object))
  )
  @member(
    IsNull Checks if the parameter value is assigned
    @return(@true if the value is assigned, @false if not)
  )
  @member(
    ChangeValue Change the current parameter value object
    @param(@link(ISQLParameterValue Parameter value object))
  )
  @member(
    Clear Set value in nil
  )
}
{$ENDREGION}
  ISQLParameter = interface(IStatement)
    ['{B688AFED-8F67-4FEA-96C4-A1B9926AADCC}']
    function Name: String;
    function Value: ISQLParameterValue;
    function IsNull: Boolean;
    procedure ChangeValue(const Value: ISQLParameterValue);
    procedure Clear;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ISQLParameter))
  @member(Name @seealso(ISQLParameter.Name))
  @member(Value @seealso(ISQLParameter.Value))
  @member(IsNull @seealso(ISQLParameter.IsNull))
  @member(ChangeValue @seealso(ISQLParameter.ChangeValue))
  @member(Clear @seealso(ISQLParameter.Clear))
  @member(Syntax @seealso(IStatement.Syntax))
  @member(
    Create Object constructor
    @param(Name Parameter name)
  )
  @member(
    New Create a new @classname as interface
    @param(Name Parameter name)
  )
  @member(
    NewWithOutName Create a new @classname as interface without a specific name
  )
}
{$ENDREGION}

  TSQLParameter = class sealed(TInterfacedObject, ISQLParameter)
  strict private
    _Name: String;
    _Value: ISQLParameterValue;
  public
    function Name: String;
    function Syntax: String;
    function Value: ISQLParameterValue;
    function IsNull: Boolean;
    procedure ChangeValue(const Value: ISQLParameterValue);
    procedure Clear;
    constructor Create(const Name: String);
    class function New(const Name: String): ISQLParameter;
    class function NewWithOutName: ISQLParameter;
  end;

{$REGION 'documentation'}
{
  @abstract(SQL parameter list object)
  List of parameters
}
{$ENDREGION}

  ISQLParameterList = interface(IIterableList<ISQLParameter>)
    ['{9EC80759-A699-4AAA-9BF5-80F7ED186B94}']
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(ISQLParameterList))
  @member(
    New Create a new @classname as interface
  )
}
{$ENDREGION}

  TSQLParameterList = class sealed(TIterableList<ISQLParameter>, ISQLParameterList)
  public
    class function New: ISQLParameterList;
  end;

implementation

function TSQLParameter.Name: String;
begin
  Result := _Name;
end;

function TSQLParameter.Syntax: String;
begin
  Result := _Name;
end;

function TSQLParameter.Value: ISQLParameterValue;
begin
  Result := _Value;
end;

function TSQLParameter.IsNull: Boolean;
begin
  Result := not Assigned(_Value);
end;

procedure TSQLParameter.ChangeValue(const Value: ISQLParameterValue);
begin
  _Value := Value;
end;

procedure TSQLParameter.Clear;
begin
  ChangeValue(nil);
end;

constructor TSQLParameter.Create(const Name: String);
begin
  _Name := Name;
end;

class function TSQLParameter.New(const Name: String): ISQLParameter;
begin
  Result := TSQLParameter.Create(Name);
end;

class function TSQLParameter.NewWithOutName: ISQLParameter;
begin
  Result := TSQLParameter.New(EmptyStr);
end;

{ TSQLParameterList }

class function TSQLParameterList.New: ISQLParameterList;
begin
  Result := TSQLParameterList.Create;
end;

end.
