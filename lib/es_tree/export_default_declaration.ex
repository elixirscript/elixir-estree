defmodule ESTree.ExportDefaultDeclaration do
  @type t :: %ESTree.ExportDefaultDeclaration{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    declaration: ESTree.Declaration.t | ESTree.Expression.t
  }
  defstruct type: "ExportDefaultDeclaration", 
  loc: nil,
  declaration: nil
end
