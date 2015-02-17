defmodule SpiderMonkey.ConditionalStatement do
  @type t :: %SpiderMonkey.ConditionalStatement{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil,
    test: SpiderMonkey.Expression.t,
    alternate: SpiderMonkey.Expression.t,
    consequent: SpiderMonkey.Expression.t
  }
  defstruct type: "ConditionalStatement", 
            loc: nil, 
            test: %SpiderMonkey.EmptyExpression{},
            alternate: %SpiderMonkey.EmptyExpression{},
            consequent: %SpiderMonkey.EmptyExpression{}
end 