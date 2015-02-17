defmodule SpiderMonkey.GraphIndexExpression do
  @type t :: %SpiderMonkey.GraphIndexExpression{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil,
    index: integer
  }
  defstruct type: "GraphIndexExpression", 
            loc: nil, 
            index: 0  
end 