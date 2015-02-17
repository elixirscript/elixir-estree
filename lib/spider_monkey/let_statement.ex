defmodule SpiderMonkey.LetStatement do
  @type t :: %SpiderMonkey.LetStatement{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil,
    head: [SpiderMonkey.VariableDeclarator.t],
    body: SpiderMonkey.Statement.t 
  }
  defstruct type: "LetStatement", 
            loc: nil, 
            head: [],
            body: %SpiderMonkey.EmptyStatement{}
end 