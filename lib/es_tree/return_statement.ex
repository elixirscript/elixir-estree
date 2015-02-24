defmodule ESTree.ReturnStatement do
  @type t :: %ESTree.ReturnStatement{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    argument: ESTree.Expression.t | nil
  }
  defstruct type: "ReturnStatement", 
            loc: nil, 
            argument: nil
end 