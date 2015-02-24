defmodule ESTree.ExportSpecifier do
  @type t :: %ESTree.ExportSpecifier{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    id: ESTree.Identifier.t,
    name: ESTree.Identifier.t | nil
  }
  defstruct type: "ExportSpecifier", 
            loc: nil,
            id: %ESTree.Identifier{},
            name: nil
end 