defmodule SpiderMonkey.ExpressionStatement do
  @type t :: %SpiderMonkey.ExpressionStatement{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil, 
    expression: SpiderMonkey.Expression.t 
  }
  defstruct type: "ExpressionStatement", loc: nil, expression: %SpiderMonkey.EmptyExpression{}
end 