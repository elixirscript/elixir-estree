defmodule ESTree.ForStatement do
  @type t :: %ESTree.ForStatement{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    init: ESTree.VariableDeclaration.t | ESTree.Expression.t  | nil,
    test: ESTree.Expression.t  | nil,
    update: ESTree.Expression.t  | nil,
    body: ESTree.Statement.t 
  }
  defstruct type: "ForStatement", 
            loc: nil, 
            init: nil,
            test: nil,
            update: nil,
            body: %ESTree.EmptyStatement{}
end 