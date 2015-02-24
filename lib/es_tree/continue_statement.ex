defmodule ESTree.ContinueStatement do
  @type t :: %ESTree.ContinueStatement{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    label: ESTree.Identifier.t | nil
  }
  defstruct type: "ContinueStatement", 
            loc: nil, 
            label: nil
end 