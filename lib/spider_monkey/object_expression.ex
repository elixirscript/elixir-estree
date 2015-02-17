defmodule SpiderMonkey.ObjectExpression do
  @type t :: %SpiderMonkey.ObjectExpression{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil,
    properties: [SpiderMonkey.Property.t]
  }
  defstruct type: "ObjectExpression", 
            loc: nil,
            properties: []
end 