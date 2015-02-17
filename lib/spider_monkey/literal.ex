defmodule SpiderMonkey.Literal do
  @type t :: %SpiderMonkey.Literal{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil,
    value: binary | boolean | number | nil
  }
  defstruct type: "Literal", 
            loc: nil,
            value: nil
end 