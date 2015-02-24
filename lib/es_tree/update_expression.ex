defmodule ESTree.UpdateExpression do
  @type t :: %ESTree.UpdateExpression{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    operator: ESTree.update_operator,
    argument: ESTree.Expression.t ,
    prefix: boolean
  }
  defstruct type: "UpdateExpression", 
            loc: nil, 
            operator: nil,
            argument: %ESTree.EmptyExpression{},
            prefix: false
end 