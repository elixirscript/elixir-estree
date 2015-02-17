defmodule SpiderMonkey.LabeledStatement do
  @type t :: %SpiderMonkey.LabeledStatement{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil,
    label: SpiderMonkey.Identifier.t,
    body: SpiderMonkey.Statement.t 
  }
  defstruct type: "LabeledStatement", 
            loc: nil, 
            label: %SpiderMonkey.Identifier{},
            body: %SpiderMonkey.EmptyStatement{}
end 