defmodule SpiderMonkey.ContinueStatement do
  @type t :: %SpiderMonkey.ContinueStatement{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil,
    label: SpiderMonkey.Identifier.t | nil
  }
  defstruct type: "ContinueStatement", 
            loc: nil, 
            label: nil
end 