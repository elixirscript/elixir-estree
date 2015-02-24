defmodule ESTree.ConditionalStatement do
  @type t :: %ESTree.ConditionalStatement{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    test: ESTree.Expression.t,
    alternate: ESTree.Expression.t,
    consequent: ESTree.Expression.t
  }
  defstruct type: "ConditionalStatement", 
            loc: nil, 
            test: %ESTree.EmptyExpression{},
            alternate: %ESTree.EmptyExpression{},
            consequent: %ESTree.EmptyExpression{}
end 