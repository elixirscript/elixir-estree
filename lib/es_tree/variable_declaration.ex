defmodule ESTree.VariableDeclaration do
  @type t :: %ESTree.VariableDeclaration{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    declarations: [ESTree.VariableDeclarator.t],
    kind: :var | :let | :const
  }
  defstruct type: "VariableDeclaration", 
            loc: nil,
            declarations: [],
            kind: :var
end 