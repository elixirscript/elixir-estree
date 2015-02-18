defmodule SpiderMonkey.ArrayPattern do
  @type t :: %SpiderMonkey.ArrayPattern{ 
    type: binary,
    loc: SpiderMonkey.SourceLocation.t | nil,
    elements: [SpiderMonkey.Pattern.t | nil]
  }
  defstruct type: "ArrayPattern",
            loc: nil,
            elements: []
end 