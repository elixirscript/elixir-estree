defmodule ESTree.ClassBody do
  @type t :: %ESTree.ClassBody{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    body: [ESTree.MethodDefinition.t]
  }
  defstruct type: "ClassBody", 
            loc: nil,
            body: []
end 