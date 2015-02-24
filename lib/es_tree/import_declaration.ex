defmodule ESTree.ImportDeclaration do
  @type t :: %ESTree.ImportDeclaration{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    specifiers: [ESTree.ImportSpecifier.t | ESTree.ImportNamespaceSpecifier.t | ESTree.ImportDefaultSpecifier.t],
    source: ESTree.Identifier.t | nil
  }
  defstruct type: "ImportDeclaration", 
            loc: nil, 
            specifiers: [],
            source: nil
end 