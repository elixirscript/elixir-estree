defmodule SpiderMonkey.ObjectPattern do
  @type t :: %SpiderMonkey.ObjectPattern{ 
    type: binary,
    properties: [SpiderMonkey.ObjectPatternProperty.t]
  }
  defstruct type: "ObjectPattern",
            properties: []
end 