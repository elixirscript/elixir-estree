defmodule ESTree.ExpressionStatement do
  @type t :: %ESTree.ExpressionStatement{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil, 
    expression: ESTree.Expression.t 
  }
  defstruct type: "ExpressionStatement", loc: nil, expression: %ESTree.EmptyExpression{}
end 