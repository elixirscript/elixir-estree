defmodule ESTree.DoWhileStatement do
  @type t :: %ESTree.DoWhileStatement{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    body: ESTree.Statement.t,
    test: ESTree.Expression.t
  }
  defstruct type: "DoWhileStatement", 
            loc: nil, 
            body: %ESTree.EmptyStatement{},
            test: %ESTree.EmptyExpression{}
end 