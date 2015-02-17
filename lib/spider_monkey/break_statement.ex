defmodule SpiderMonkey.BreakStatement do
  @type t :: %SpiderMonkey.BreakStatement{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil,
    label: SpiderMonkey.Identifier.t | nil
  }
  defstruct type: "BreakStatement", 
            loc: nil, 
            label: nil
end 