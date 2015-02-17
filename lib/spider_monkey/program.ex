defmodule SpiderMonkey.Program do
  @type t :: %SpiderMonkey.Program{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil, 
    body: [SpiderMonkey.Statement.t ] 
  }
  defstruct type: "Program", loc: nil, body: []
end