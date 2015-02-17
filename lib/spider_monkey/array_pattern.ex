defmodule SpiderMonkey.ArrayPattern do
  @type t :: %SpiderMonkey.ArrayPattern{ 
    type: binary,
    elements: [SpiderMonkey.Pattern.t | nil]
  }
  defstruct type: "ArrayPattern",
            elements: []
end 