defmodule SpiderMonkey.SwitchCase do
  @type t :: %SpiderMonkey.SwitchCase{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil,
    test: SpiderMonkey.Expression.t | nil,
    consequent: [SpiderMonkey.Statement.t]
  }
  defstruct type: "SwitchCase", 
            loc: nil, 
            test: nil,
            consequent: []
end 