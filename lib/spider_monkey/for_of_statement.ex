defmodule SpiderMonkey.ForOfStatement do
  @type t :: %SpiderMonkey.ForOfStatement{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil,
    left: SpiderMonkey.VariableDeclaration.t | SpiderMonkey.Expression.t ,
    right: SpiderMonkey.Expression.t ,
    body: SpiderMonkey.Statement.t 
  }
  defstruct type: "ForOfStatement", 
            loc: nil, 
            left: %SpiderMonkey.EmptyExpression{},
            right: %SpiderMonkey.EmptyExpression{},
            body: %SpiderMonkey.EmptyStatement{}
end 