defmodule ESTree.ExportDeclaration do
  @type t :: %ESTree.ExportDeclaration{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    declaration: ESTree.Declaration.t,
    specifiers: [ESTree.ExportSpecifier.t],
    default: boolean,
    source: ESTree.Identifier.t | nil
  }
  defstruct type: "ExportDeclaration", 
            loc: nil, 
            declaration: %ESTree.EmptyStatement{},
            specifiers: nil,
            default: false,
            source: nil
end 