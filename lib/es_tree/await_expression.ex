defmodule ESTree.AwaitExpression do
  @type t :: %ESTree.AwaitExpression{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    argument: ESTree.Expression.t | nil,
    all: boolean
  }
  defstruct type: "AwaitExpression", 
            loc: nil, 
            argument: nil,
            all: false         
end 