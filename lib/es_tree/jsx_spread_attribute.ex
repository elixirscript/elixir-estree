defmodule ESTree.JSXSpreadAttribute do
  @type t :: %ESTree.JSXSpreadAttribute{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    argument: ESTree.Expression.t
  }
  defstruct type: "JSXSpreadAttribute", 
  loc: nil, 
  argument: %ESTree.EmptyExpression{}
end
