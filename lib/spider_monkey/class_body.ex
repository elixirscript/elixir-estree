defmodule SpiderMonkey.ClassBody do
  @type t :: %SpiderMonkey.ClassBody{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil,
    body: [SpiderMonkey.MethodDefinition.t]
  }
  defstruct type: "ClassBody", 
            loc: nil,
            body: []
end 