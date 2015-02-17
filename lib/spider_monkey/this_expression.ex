defmodule SpiderMonkey.ThisExpression do
  @type t :: %SpiderMonkey.ThisExpression{ type: binary, loc: SpiderMonkey.SourceLocation.t | nil }
  defstruct type: "ThisExpression", loc: nil
end 