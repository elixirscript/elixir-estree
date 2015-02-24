defmodule ESTree.LogicalExpression do
  @type t :: %ESTree.LogicalExpression{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    operator: ESTree.logical_operator,
    left: ESTree.Expression.t ,
    right: ESTree.Expression.t  
  }
  defstruct type: "LogicalExpression", 
            loc: nil, 
            operator: nil,
            left: %ESTree.EmptyExpression{},
            right: %ESTree.EmptyExpression{}            
end 