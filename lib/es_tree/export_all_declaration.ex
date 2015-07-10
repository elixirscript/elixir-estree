defmodule ESTree.ExportAllDeclaration do
  @type t :: %ESTree.ExportAllDeclaration{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil,
    source: ESTree.Identifier.t | nil
  }
  defstruct type: "ExportAllDeclaration", 
            loc: nil,
            source: nil
end 
