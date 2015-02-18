defmodule SpiderMonkey.ClassExpression do
  @type t :: %SpiderMonkey.ClassExpression{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil,
    body: [SpiderMonkey.MethodDefinition.t]
  }
  defstruct type: "ClassExpression", 
            loc: nil,
            body: []
end 