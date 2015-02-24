defmodule ESTree.ObjectPatternProperty do
  @type t :: %ESTree.ObjectPatternProperty{ 
    key: ESTree.Literal.t | ESTree.Identifier.t, 
    value: ESTree.Pattern.t
  }
  defstruct key: %ESTree.Literal{}, 
            value: %ESTree.EmptyExpression{}
end 