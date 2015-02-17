defmodule SpiderMonkey.Property do
  @type t :: %SpiderMonkey.Property{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil,
    key: SpiderMonkey.Literal.t | SpiderMonkey.Identifier.t,
    value: SpiderMonkey.Expression.t ,
    kind: :init | :get | :set
  }
  defstruct type: "Property", 
            loc: nil,
            key: %SpiderMonkey.Literal{},
            value: %SpiderMonkey.EmptyExpression{},
            kind: :init
end 