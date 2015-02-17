defmodule SpiderMonkey.UpdateExpression do
  @type t :: %SpiderMonkey.UpdateExpression{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil,
    operator: SpiderMonkey.update_expression,
    argument: SpiderMonkey.Expression.t ,
    prefix: boolean
  }
  defstruct type: "UpdateExpression", 
            loc: nil, 
            operator: nil,
            argument: %SpiderMonkey.EmptyExpression{},
            prefix: false
end 