defmodule SpiderMonkey.SequenceExpression do
  @type t :: %SpiderMonkey.SequenceExpression{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil, 
    expressions: [SpiderMonkey.Expression.t ]
  }
  defstruct type: "SequenceExpression", loc: nil, expressions: []
end 