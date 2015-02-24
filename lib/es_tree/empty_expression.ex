defmodule ESTree.EmptyExpression do
  @type t :: %ESTree.EmptyExpression{ type: binary, loc: ESTree.SourceLocation.t | nil }
  defstruct type: "EmptyExpression", loc: nil
end 