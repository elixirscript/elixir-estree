defmodule ESTree.CallExpression do
  @type t :: %ESTree.CallExpression{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil, 
    callee: ESTree.Expression.t | ESTree.Super.t,
    arguments: [ESTree.Expression.t | ESTree.SpreadElement.t]
  }
  defstruct type: "CallExpression", 
            loc: nil, 
            callee: %ESTree.EmptyExpression{},
            arguments: []          
end 
