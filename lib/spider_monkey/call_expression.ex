defmodule SpiderMonkey.CallExpression do
  @type t :: %SpiderMonkey.CallExpression{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil, 
    callee: SpiderMonkey.Expression.t,
    arguments: [SpiderMonkey.Expression.t]
  }
  defstruct type: "CallExpression", 
            loc: nil, 
            operator: nil,
            callee: %SpiderMonkey.EmptyExpression{},
            arguments: []           
end 