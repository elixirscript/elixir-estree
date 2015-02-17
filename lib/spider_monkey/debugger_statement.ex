defmodule SpiderMonkey.DebuggerStatement do
  @type t :: %SpiderMonkey.DebuggerStatement{ type: binary, loc: SpiderMonkey.SourceLocation.t | nil }
  defstruct type: "DebuggerStatement", loc: nil
end 