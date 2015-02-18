defmodule SpiderMonkey.BinaryExpression do
  @type t :: %SpiderMonkey.BinaryExpression{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil,
    operator: SpiderMonkey.binary_operator,
    left: SpiderMonkey.Expression.t,
    right: SpiderMonkey.Expression.t 
  }
  defstruct type: "BinaryExpression", 
            loc: nil, 
            operator: nil,
            left: %SpiderMonkey.EmptyExpression{},
            right: %SpiderMonkey.EmptyExpression{}            
end 