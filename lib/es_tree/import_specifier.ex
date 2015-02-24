defmodule ESTree.ImportSpecifier do
  @type t :: %ESTree.ImportSpecifier{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    id: ESTree.Identifier.t,
    name: ESTree.Identifier.t | nil,
    default: boolean
  }
  defstruct type: "ImportSpecifier", 
            loc: nil, 
            id: %ESTree.Identifier{},
            name: nil,
            default: false
end 