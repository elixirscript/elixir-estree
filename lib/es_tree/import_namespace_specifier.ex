defmodule ESTree.ImportNamespaceSpecifier do
  @type t :: %ESTree.ImportNamespaceSpecifier{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    local: ESTree.Identifier.t
  }
  defstruct type: "ImportNamespaceSpecifier", 
            loc: nil, 
            local: %ESTree.Identifier{}
end 
