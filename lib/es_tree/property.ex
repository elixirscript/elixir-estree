defmodule ESTree.Property do
  @type t :: %ESTree.Property{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    key: ESTree.Expression.t,
    value: ESTree.Expression.t,
    kind: :init | :get | :set,
    method: boolean,
    shorthand: boolean,
    computed: boolean
  }
  defstruct type: "Property", 
            loc: nil,
            key: %ESTree.Literal{},
            value: %ESTree.EmptyExpression{},
            kind: :init,
            method: false,
            shorthand: false,
            computed: false
end 
