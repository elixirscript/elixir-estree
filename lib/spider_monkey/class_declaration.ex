defmodule SpiderMonkey.ClassDeclaration do
  @type t :: %SpiderMonkey.ClassDeclaration{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil,
    id: SpiderMonkey.Identifier.t,
    body: SpiderMonkey.ClassBody.t
  }
  defstruct type: "ClassDeclaration", 
            loc: nil,
            id: %SpiderMonkey.Identifier{},
            body: %SpiderMonkey.ClassBody{}
end 