defmodule ESTree.UnaryExpression do
  @type t :: %ESTree.UnaryExpression{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    operator: ESTree.unary_operator,
    prefix: boolean,
    argument: ESTree.Expression.t  
  }
  defstruct type: "UnaryExpression", 
            loc: nil, 
            operator: nil, 
            prefix: false, 
            argument: %ESTree.EmptyExpression{}
end 