defmodule SpiderMonkey.ForStatement do
  @type t :: %SpiderMonkey.ForStatement{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil,
    init: SpiderMonkey.VariableDeclaration.t | SpiderMonkey.Expression.t  | nil,
    test: SpiderMonkey.Expression.t  | nil,
    update: SpiderMonkey.Expression.t  | nil,
    body: SpiderMonkey.Statement.t 
  }
  defstruct type: "ForStatement", 
            loc: nil, 
            init: nil,
            test: nil,
            update: nil,
            body: %SpiderMonkey.EmptyStatement{}
end 