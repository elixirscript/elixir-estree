defmodule ESTree.ExportSpecifier do
  @type t :: %ESTree.ExportSpecifier{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    local: ESTree.Identifier.t,
    exported: ESTree.Identifier.t
  }
  defstruct type: "ExportSpecifier", 
            loc: nil,
            local: %ESTree.Identifier{},
            exported: %ESTree.Identifier{}
end 
