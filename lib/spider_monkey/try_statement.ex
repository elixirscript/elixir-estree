defmodule SpiderMonkey.TryStatement do
  @type t :: %SpiderMonkey.TryStatement{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil,
    block: SpiderMonkey.BlockStatement.t,
    handler: SpiderMonkey.CaseClause.t | nil,
    guardedHandlers: [SpiderMonkey.CaseClause.t],
    finalizer: SpiderMonkey.BlockStatement.t | nil
  }
  defstruct type: "TryStatement", 
            loc: nil, 
            block: %SpiderMonkey.BlockStatement{},
            handler: nil,
            guardedHandlers: [],
            finalizer: nil
end 