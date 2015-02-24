defmodule ESTree.DebuggerStatement do
  @type t :: %ESTree.DebuggerStatement{ type: binary, loc: ESTree.SourceLocation.t | nil }
  defstruct type: "DebuggerStatement", loc: nil
end 