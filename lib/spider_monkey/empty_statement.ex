defmodule SpiderMonkey.EmptyStatement do
  @type t :: %SpiderMonkey.EmptyStatement{ type: binary, loc: SpiderMonkey.SourceLocation.t | nil }
  defstruct type: "EmptyStatement", loc: nil
end 