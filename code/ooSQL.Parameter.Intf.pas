{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQL.Parameter.Intf;

interface

uses
  SysUtils,
  ooFilter.Parameter;

const
  PARAMETER_PREFIX = ':';
  PARAMETER_NULL = 'NULL';

type
  ISQLParameter = interface(IParameterBase)
    ['{B688AFED-8F67-4FEA-96C4-A1B9926AADCC}']
    function ValueParsed: String;
    function NameParsed: String;
  end;

  TSQLParameterArray = array of ISQLParameter;

function HasDynamicPrefix(const Value: String): Boolean;

implementation

function HasDynamicPrefix(const Value: String): Boolean;
begin
  Result := TrimLeft(Value)[1] = PARAMETER_PREFIX;
end;

end.
