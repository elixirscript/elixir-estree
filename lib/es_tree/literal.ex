defmodule ESTree.Literal do
  @type t :: %ESTree.Literal{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    value: binary | boolean | number | nil
  }
  defstruct type: "Literal", 
            loc: nil,
            value: nil
end 