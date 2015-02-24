defmodule ESTree.NewExpression do
  @type t :: %ESTree.NewExpression{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil, 
    callee: ESTree.Expression.t ,
    arguments: [ESTree.Expression.t ]
  }
  defstruct type: "NewExpression", 
            loc: nil, 
            callee: %ESTree.EmptyExpression{},
            arguments: []           
end 