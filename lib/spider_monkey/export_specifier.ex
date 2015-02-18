defmodule SpiderMonkey.ExportSpecifier do
  @type t :: %SpiderMonkey.ExportSpecifier{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil
  }
  defstruct type: "ExportSpecifier", 
            loc: nil
end 