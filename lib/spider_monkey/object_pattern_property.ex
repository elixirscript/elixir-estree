defmodule SpiderMonkey.ObjectPatternProperty do
  @type t :: %SpiderMonkey.ObjectPatternProperty{ 
    key: SpiderMonkey.Literal.t | SpiderMonkey.Identifier.t, 
    value: SpiderMonkey.Pattern.t
  }
  defstruct key: %SpiderMonkey.Literal{}, 
            value: %SpiderMonkey.EmptyExpression{}
end 