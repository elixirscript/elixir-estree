defmodule SpiderMonkey.ArrayExpression do
  @type t :: %SpiderMonkey.ArrayExpression{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil,
    elements: [SpiderMonkey.Expression.t | nil]
  }
  defstruct type: "ArrayExpression", 
            loc: nil,
            elements: []
end 