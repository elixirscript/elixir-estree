defmodule SpiderMonkey.Identifier do
  @type t :: %SpiderMonkey.Identifier{ 
    type: binary,
    loc: SpiderMonkey.SourceLocation.t | nil, 
    name: binary
  }
  defstruct type: "Identifier", loc: nil, name: nil
end 