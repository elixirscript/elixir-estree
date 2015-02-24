defmodule ESTree.ClassDeclaration do
  @type t :: %ESTree.ClassDeclaration{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    id: ESTree.Identifier.t,
    body: ESTree.ClassBody.t,
    superClass: ESTree.Expression.t | nil
  }
  defstruct type: "ClassDeclaration", 
            loc: nil,
            id: %ESTree.Identifier{},
            body: %ESTree.ClassBody{},
            superClass: nil
end 