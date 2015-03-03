defmodule ESTree.Literal do
  @type t :: %ESTree.Literal{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    value: binary | boolean | number | nil,
    regex: ESTree.Regex.t | nil
  }
  defstruct type: "Literal", 
            loc: nil,
            value: nil,
            regex: nil
end 