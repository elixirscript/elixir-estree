defmodule SpiderMonkey.LogicalExpression do
  @type t :: %SpiderMonkey.LogicalExpression{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil,
    operator: SpiderMonkey.logical_expression,
    left: SpiderMonkey.Expression.t ,
    right: SpiderMonkey.Expression.t  
  }
  defstruct type: "LogicalExpression", 
            loc: nil, 
            operator: nil,
            left: %SpiderMonkey.EmptyExpression{},
            right: %SpiderMonkey.EmptyExpression{}            
end 