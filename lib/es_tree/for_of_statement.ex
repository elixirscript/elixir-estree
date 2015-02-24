defmodule ESTree.ForOfStatement do
  @type t :: %ESTree.ForOfStatement{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    left: ESTree.VariableDeclaration.t | ESTree.Expression.t ,
    right: ESTree.Expression.t ,
    body: ESTree.Statement.t 
  }
  defstruct type: "ForOfStatement", 
            loc: nil, 
            left: %ESTree.EmptyExpression{},
            right: %ESTree.EmptyExpression{},
            body: %ESTree.EmptyStatement{}
end 