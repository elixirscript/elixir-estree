defmodule SpiderMonkey.WhileStatement do
  @type t :: %SpiderMonkey.WhileStatement{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil,
    test: SpiderMonkey.Expression.t ,
    body: SpiderMonkey.Statement.t 
  }
  defstruct type: "WhileStatement", 
            loc: nil, 
            test: %SpiderMonkey.EmptyExpression{},
            body: %SpiderMonkey.EmptyStatement{}
end 