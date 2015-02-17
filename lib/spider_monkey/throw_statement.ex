defmodule SpiderMonkey.ThrowStatement do
  @type t :: %SpiderMonkey.ThrowStatement{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil,
    argument: SpiderMonkey.Expression.t 
  }
  defstruct type: "ThrowStatement", 
            loc: nil, 
            argument: %SpiderMonkey.EmptyExpression{}
end 