defmodule ESTree.TryStatement do
  @type t :: %ESTree.TryStatement{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    block: ESTree.BlockStatement.t,
    handler: ESTree.CaseClause.t | nil,
    finalizer: ESTree.BlockStatement.t | nil
  }
  defstruct type: "TryStatement", 
            loc: nil, 
            block: %ESTree.BlockStatement{},
            handler: nil,
            finalizer: nil
end 