defmodule ESTree.WithStatement do
  @type t :: %ESTree.WithStatement{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    object: ESTree.Expression.t ,
    body: ESTree.Statement.t 
  }
  defstruct type: "WithStatement", 
            loc: nil, 
            object: %ESTree.EmptyExpression{},
            body: %ESTree.EmptyStatement{}
end 