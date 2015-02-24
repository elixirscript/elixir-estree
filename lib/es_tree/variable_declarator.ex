defmodule ESTree.VariableDeclarator do
  @type t :: %ESTree.VariableDeclarator{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    id: ESTree.Pattern.t ,
    init: ESTree.Expression.t  | nil
  }
  defstruct type: "VariableDeclarator", 
            loc: nil,
            id: %ESTree.EmptyExpression{},
            init: nil
end 