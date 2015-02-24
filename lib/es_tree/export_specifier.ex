defmodule ESTree.ExportSpecifier do
  @type t :: %ESTree.ExportSpecifier{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil
  }
  defstruct type: "ExportSpecifier", 
            loc: nil
end 