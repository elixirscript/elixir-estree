defmodule SpiderMonkey.NewExpression do
  @type t :: %SpiderMonkey.NewExpression{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil, 
    callee: SpiderMonkey.Expression.t ,
    arguments: [SpiderMonkey.Expression.t ]
  }
  defstruct type: "NewExpression", 
            loc: nil, 
            operator: nil,
            callee: %SpiderMonkey.EmptyExpression{},
            arguments: []           
end 