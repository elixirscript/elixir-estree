defmodule SpiderMonkey.BlockStatement do
  @type t :: %SpiderMonkey.BlockStatement{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil, 
    body: [SpiderMonkey.Statement.t] 
  }
  defstruct type: "BlockStatement", loc: nil, body: []
end 