defmodule ESTree.ExportNamedDeclaration do
  @type t :: %ESTree.ExportNamedDeclaration{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    declaration: ESTree.Declaration.t | nil,
    specifiers: [ESTree.ExportSpecifier],
    source: ESTree.Literal.t | nil
  }
  defstruct type: "ExportNamedDeclaration", 
  loc: nil,
  declaration: nil,
  specifiers: [],
  source: nil
end
