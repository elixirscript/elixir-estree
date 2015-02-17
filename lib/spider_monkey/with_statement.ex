defmodule SpiderMonkey.WithStatement do
  @type t :: %SpiderMonkey.WithStatement{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil,
    object: SpiderMonkey.Expression.t ,
    body: SpiderMonkey.Statement.t 
  }
  defstruct type: "WithStatement", 
            loc: nil, 
            object: %SpiderMonkey.EmptyExpression{},
            body: %SpiderMonkey.EmptyStatement{}
end 