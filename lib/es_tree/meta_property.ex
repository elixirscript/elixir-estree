defmodule ESTree.MetaProperty do
  @type t :: %ESTree.MetaProperty{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    meta: ESTree.Identifier.t,
    property: ESTree.Identifier.t
  }
  defstruct type: "MetaProperty", 
            loc: nil,
            meta: %ESTree.Identifier{},
            property: %ESTree.Identifier{}
end
