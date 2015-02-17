defmodule SpiderMonkey.YieldExpression do
  @type t :: %SpiderMonkey.YieldExpression{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil, 
    argument: SpiderMonkey.Expression.t | nil
  }
  defstruct type: "YieldExpression", 
            loc: nil,
            argument: nil
end 