defmodule ESTree.JSXEmptyExpression do
  @type t :: %ESTree.JSXEmptyExpression{ type: binary, loc: ESTree.SourceLocation.t | nil }
  defstruct type: "JSXEmptyExpression", loc: nil
end 
