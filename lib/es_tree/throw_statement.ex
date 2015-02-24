defmodule ESTree.ThrowStatement do
  @type t :: %ESTree.ThrowStatement{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    argument: ESTree.Expression.t 
  }
  defstruct type: "ThrowStatement", 
            loc: nil, 
            argument: %ESTree.EmptyExpression{}
end 