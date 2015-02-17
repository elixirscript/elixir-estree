defmodule SpiderMonkey.EmptyExpression do
  @type t :: %SpiderMonkey.EmptyExpression{ type: binary, loc: SpiderMonkey.SourceLocation.t | nil }
  defstruct type: "EmptyExpression", loc: nil
end 