defmodule SpiderMonkey.GraphExpression do
  @type t :: %SpiderMonkey.GraphExpression{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil,
    index: integer,
    expression: SpiderMonkey.Literal.t
  }
  defstruct type: "GraphExpression", 
            loc: nil, 
            index: 0,
            expression: %SpiderMonkey.Literal{}       
end 