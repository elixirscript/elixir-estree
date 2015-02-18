defmodule SpiderMonkey.ImportSpecifier do
  @type t :: %SpiderMonkey.ImportSpecifier{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil,
    id: SpiderMonkey.Identifier.t,
    name: SpiderMonkey.Identifier.t | nil,
    default: boolean
  }
  defstruct type: "ImportSpecifier", 
            loc: nil, 
            id: %SpiderMonkey.Identifier{},
            name: nil,
            default: false
end 