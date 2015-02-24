defmodule ESTree.Identifier do
  @type t :: %ESTree.Identifier{ 
    type: binary,
    loc: ESTree.SourceLocation.t | nil, 
    name: binary
  }
  defstruct type: "Identifier", loc: nil, name: nil
end 