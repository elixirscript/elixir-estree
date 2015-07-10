defmodule ESTree.AssignmentPattern do
  @type t :: %ESTree.AssignmentPattern{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    left: ESTree.Pattern.t,
    right: ESTree.Expression.t
  }
  defstruct type: "AssignmentPattern", 
            loc: nil,
            left: nil,
            right: nil
end
