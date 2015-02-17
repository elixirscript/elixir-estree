defmodule SpiderMonkey.ReturnStatement do
  @type t :: %SpiderMonkey.ReturnStatement{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil,
    argument: SpiderMonkey.Expression.t | nil
  }
  defstruct type: "ReturnStatement", 
            loc: nil, 
            argument: nil
end 