defmodule ESTree.BinaryExpression do
  @type t :: %ESTree.BinaryExpression{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    operator: ESTree.binary_operator,
    left: ESTree.Expression.t,
    right: ESTree.Expression.t 
  }
  defstruct type: "BinaryExpression", 
            loc: nil, 
            operator: nil,
            left: %ESTree.EmptyExpression{},
            right: %ESTree.EmptyExpression{}            
end 