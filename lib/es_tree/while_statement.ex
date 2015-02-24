defmodule ESTree.WhileStatement do
  @type t :: %ESTree.WhileStatement{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    test: ESTree.Expression.t ,
    body: ESTree.Statement.t 
  }
  defstruct type: "WhileStatement", 
            loc: nil, 
            test: %ESTree.EmptyExpression{},
            body: %ESTree.EmptyStatement{}
end 