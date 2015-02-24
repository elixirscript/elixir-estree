defmodule ESTree.IfStatement do
  @type t :: %ESTree.IfStatement{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    test: ESTree.Expression.t ,
    consequent: ESTree.Statement.t ,
    alternate: ESTree.Statement.t  | nil
  }
  defstruct type: "IfStatement", 
            loc: nil, 
            test: %ESTree.EmptyExpression{},
            consequent: %ESTree.EmptyStatement{},
            alternate: nil
end 