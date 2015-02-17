defmodule SpiderMonkey.AssignmentExpression do
  @type t :: %SpiderMonkey.AssignmentExpression{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil,
    operator: SpiderMonkey.assignment_expression,
    left: SpiderMonkey.Pattern.t, 
    right: SpiderMonkey.Expression.t
  }
  defstruct type: "AssignmentExpression", 
            loc: nil, 
            operator: nil,
            left: %SpiderMonkey.EmptyExpression{},
            right: %SpiderMonkey.EmptyExpression{}            
end 