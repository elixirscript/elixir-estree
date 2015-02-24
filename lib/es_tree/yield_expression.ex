defmodule ESTree.YieldExpression do
  @type t :: %ESTree.YieldExpression{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil, 
    argument: ESTree.Expression.t | nil
  }
  defstruct type: "YieldExpression", 
            loc: nil,
            argument: nil
end 