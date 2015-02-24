defmodule ESTree.BreakStatement do
  @type t :: %ESTree.BreakStatement{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    label: ESTree.Identifier.t | nil
  }
  defstruct type: "BreakStatement", 
            loc: nil, 
            label: nil
end 