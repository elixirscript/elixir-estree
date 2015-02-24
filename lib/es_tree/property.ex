defmodule ESTree.Property do
  @type t :: %ESTree.Property{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    key: ESTree.Literal.t | ESTree.Identifier.t,
    value: ESTree.Expression.t ,
    kind: :init | :get | :set
  }
  defstruct type: "Property", 
            loc: nil,
            key: %ESTree.Literal{},
            value: %ESTree.EmptyExpression{},
            kind: :init
end 