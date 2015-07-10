defmodule ESTree.YieldExpression do
  @type t :: %ESTree.YieldExpression{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil, 
    argument: ESTree.Expression.t | nil,
    delegate: boolean
  }
  defstruct type: "YieldExpression", 
            loc: nil,
            argument: nil,
            delegate: false
end 
