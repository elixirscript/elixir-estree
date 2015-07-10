defmodule ESTree.ClassExpression do
  @type t :: %ESTree.ClassExpression{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    body: ESTree.ClassBody.t,
    superClass: ESTree.Expression.t | nil
  }
  defstruct type: "ClassExpression", 
            loc: nil,
            body: %ESTree.ClassBody{},
            superClass: nil
end 
