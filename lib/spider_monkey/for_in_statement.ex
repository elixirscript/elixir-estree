defmodule SpiderMonkey.ForInStatement do
  @type t :: %SpiderMonkey.ForInStatement{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil,
    left: SpiderMonkey.VariableDeclaration.t | SpiderMonkey.Expression.t ,
    right: SpiderMonkey.Expression.t ,
    body: SpiderMonkey.Statement.t
  }
  defstruct type: "ForInStatement", 
            loc: nil, 
            left: %SpiderMonkey.EmptyExpression{},
            right: %SpiderMonkey.EmptyExpression{},
            body: %SpiderMonkey.EmptyStatement{}
end 