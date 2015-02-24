defmodule ESTree.EmptyStatement do
  @type t :: %ESTree.EmptyStatement{ type: binary, loc: ESTree.SourceLocation.t | nil }
  defstruct type: "EmptyStatement", loc: nil
end 