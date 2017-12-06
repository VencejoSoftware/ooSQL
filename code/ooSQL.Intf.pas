{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooSQL.Intf;

interface

uses
  ooText.Beautify.Intf,
  ooSQL.Parameter.Intf;

type
  ISQL = interface
    ['{54C73588-FA72-4FA3-8803-2B6857411C7D}']
    function SQL: String;
    function Parse(const Parameters: array of ISQLParameter; const Beautify: ITextBeautify): String;
  end;

implementation

end.
