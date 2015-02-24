defmodule ESTree.ImportDeclaration do
  @type t :: %ESTree.ImportDeclaration{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    specifiers: [ESTree.ImportSpecifier.t],
    source: ESTree.Identifier.t | nil
  }
  defstruct type: "ImportDeclaration", 
            loc: nil, 
            specifiers: [],
            source: nil
end 