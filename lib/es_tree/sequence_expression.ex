defmodule ESTree.SequenceExpression do
  @type t :: %ESTree.SequenceExpression{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil, 
    expressions: [ESTree.Expression.t ]
  }
  defstruct type: "SequenceExpression", loc: nil, expressions: []
end 