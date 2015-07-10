defmodule ESTree.ImportSpecifier do
  @type t :: %ESTree.ImportSpecifier{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    local: ESTree.Identifier.t,
    imported: ESTree.Identifier.t
  }
  defstruct type: "ImportSpecifier", 
            loc: nil, 
            local: %ESTree.Identifier{},
            imported: %ESTree.Identifier{}
end 
