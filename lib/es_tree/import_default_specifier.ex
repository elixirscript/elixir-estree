defmodule ESTree.ImportDefaultSpecifier do
  @type t :: %ESTree.ImportDefaultSpecifier{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    id: ESTree.Identifier.t
  }
  defstruct type: "ImportDefaultSpecifier", 
            loc: nil, 
            id: %ESTree.Identifier{}
end 