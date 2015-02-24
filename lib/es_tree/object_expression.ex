defmodule ESTree.ObjectExpression do
  @type t :: %ESTree.ObjectExpression{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    properties: [ESTree.Property.t]
  }
  defstruct type: "ObjectExpression", 
            loc: nil,
            properties: []
end 