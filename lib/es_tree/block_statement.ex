defmodule ESTree.BlockStatement do
  @type t :: %ESTree.BlockStatement{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil, 
    body: [ESTree.Statement.t] 
  }
  defstruct type: "BlockStatement", loc: nil, body: []
end 