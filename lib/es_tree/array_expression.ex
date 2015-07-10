defmodule ESTree.ArrayExpression do
  @type t :: %ESTree.ArrayExpression{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    elements: [ESTree.Expression.t | ESTree.SpreadElement.t | nil]
  }
  defstruct type: "ArrayExpression", 
            loc: nil,
            elements: []
end 
