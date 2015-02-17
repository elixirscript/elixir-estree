defmodule SpiderMonkey.DoWhileStatement do
  @type t :: %SpiderMonkey.DoWhileStatement{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil,
    body: SpiderMonkey.Statement.t,
    test: SpiderMonkey.Expression.t
  }
  defstruct type: "DoWhileStatement", 
            loc: nil, 
            body: %SpiderMonkey.EmptyStatement{},
            test: %SpiderMonkey.EmptyExpression{}
end 