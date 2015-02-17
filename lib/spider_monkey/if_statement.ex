defmodule SpiderMonkey.IfStatement do
  @type t :: %SpiderMonkey.IfStatement{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil,
    test: SpiderMonkey.Expression.t ,
    consequent: SpiderMonkey.Statement.t ,
    alternate: SpiderMonkey.Statement.t  | nil
  }
  defstruct type: "IfStatement", 
            loc: nil, 
            test: %SpiderMonkey.EmptyExpression{},
            consequent: %SpiderMonkey.EmptyStatement{},
            alternate: nil
end 