defmodule ESTree.ThisExpression do
  @type t :: %ESTree.ThisExpression{ type: binary, loc: ESTree.SourceLocation.t | nil }
  defstruct type: "ThisExpression", loc: nil
end 