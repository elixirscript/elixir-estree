defmodule SpiderMonkey.ClassExpression do
  @type t :: %SpiderMonkey.ClassExpression{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil,
    body: SpiderMonkey.ClassBody.t
  }
  defstruct type: "ClassExpression", 
            loc: nil,
            body: %SpiderMonkey.ClassBody{}
end 