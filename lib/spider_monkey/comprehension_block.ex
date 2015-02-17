defmodule SpiderMonkey.ComprehensionBlock do
  @type t :: %SpiderMonkey.ComprehensionBlock{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil,
    left: SpiderMonkey.Pattern.t,
    right: SpiderMonkey.Expression.t,
    each: boolean
  }
  defstruct type: "ComprehensionBlock", 
            loc: nil, 
            left: %SpiderMonkey.EmptyExpression{},
            right: %SpiderMonkey.EmptyExpression{},
            each: false
end 