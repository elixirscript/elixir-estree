defmodule ESTree.ForInStatement do
  @type t :: %ESTree.ForInStatement{
    type: binary,
    loc: ESTree.SourceLocation.t | nil,
    left: ESTree.VariableDeclaration.t | ESTree.Pattern.t ,
    right: ESTree.Expression.t ,
    body: ESTree.Statement.t
  }
  defstruct type: "ForInStatement", 
            loc: nil, 
            left: %ESTree.EmptyExpression{},
            right: %ESTree.EmptyExpression{},
            body: %ESTree.EmptyStatement{}
end 
