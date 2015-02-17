defmodule SpiderMonkey.CatchCase do
  @type t :: %SpiderMonkey.CatchCase{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil,
    param: SpiderMonkey.Pattern.t,
    guard: SpiderMonkey.Expression.t | nil,
    body: SpiderMonkey.BlockStatement
  }
  defstruct type: "CatchCase", 
            loc: nil, 
            param: %SpiderMonkey.EmptyExpression{},
            guard: nil,
            body: %SpiderMonkey.BlockStatement{}
end 