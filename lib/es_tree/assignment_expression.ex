defmodule ESTree.AssignmentExpression do
  @type t :: %ESTree.AssignmentExpression{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    operator: ESTree.assignment_operator,
    left: ESTree.Pattern.t | ESTree.Expression.t, 
    right: ESTree.Expression.t
  }
  defstruct type: "AssignmentExpression", 
            loc: nil, 
            operator: nil,
            left: %ESTree.EmptyExpression{},
            right: %ESTree.EmptyExpression{}            
end 