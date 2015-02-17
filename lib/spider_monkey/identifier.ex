defmodule SpiderMonkey.Identifier do
  @type t :: %SpiderMonkey.Identifier{ 
    type: binary, 
    name: binary
  }
  defstruct type: "Identifier", name: nil
end 