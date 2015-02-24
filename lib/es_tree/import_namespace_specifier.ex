defmodule ESTree.ImportNamespaceSpecifier do
  @type t :: %ESTree.ImportNamespaceSpecifier{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    id: ESTree.Identifier.t
  }
  defstruct type: "ImportNamespaceSpecifier", 
            loc: nil, 
            id: %ESTree.Identifier{}
end 