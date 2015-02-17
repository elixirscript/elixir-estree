defmodule SpiderMonkey.UnaryExpression do
  @type t :: %SpiderMonkey.UnaryExpression{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil,
    operator: SpiderMonkey.unary_expression,
    prefix: boolean,
    argument: SpiderMonkey.Expression.t  
  }
  defstruct type: "UnaryExpression", 
            loc: nil, 
            operator: nil, 
            prefix: false, 
            argument: %SpiderMonkey.EmptyExpression{}
end 