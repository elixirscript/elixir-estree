defmodule SpiderMonkey.ObjectPattern do
  @type t :: %SpiderMonkey.ObjectPattern{ 
    type: binary,
    loc: SpiderMonkey.SourceLocation.t | nil,
    properties: [SpiderMonkey.ObjectPatternProperty.t]
  }
  defstruct type: "ObjectPattern",
            loc: nil,
            properties: []
end 