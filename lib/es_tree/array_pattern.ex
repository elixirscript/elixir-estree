defmodule ESTree.ArrayPattern do
  @type t :: %ESTree.ArrayPattern{ 
    type: binary,
    loc: ESTree.SourceLocation.t | nil,
    elements: [ESTree.Pattern.t | nil]
  }
  defstruct type: "ArrayPattern",
            loc: nil,
            elements: []
end 