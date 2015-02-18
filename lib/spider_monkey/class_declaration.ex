defmodule SpiderMonkey.ClassDeclaration do
  @type t :: %SpiderMonkey.ClassDeclaration{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil,
    id: SpiderMonkey.Identifier.t,
    body: [SpiderMonkey.MethodDefinition.t]
  }
  defstruct type: "ClassDeclaration", 
            loc: nil,
            id: %SpiderMonkey.Identifier{},
            body: []
end 