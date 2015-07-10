defmodule ESTree.ImportDefaultSpecifier do
  @type t :: %ESTree.ImportDefaultSpecifier{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    local: ESTree.Identifier.t
  }
  defstruct type: "ImportDefaultSpecifier", 
            loc: nil, 
            local: %ESTree.Identifier{}
end 
