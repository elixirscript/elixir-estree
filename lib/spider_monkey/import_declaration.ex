defmodule SpiderMonkey.ImportDeclaration do
  @type t :: %SpiderMonkey.ImportDeclaration{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil,
    specifiers: [SpiderMonkey.ImportSpecifier.t],
    source: SpiderMonkey.Identifier.t | nil
  }
  defstruct type: "ImportDeclaration", 
            loc: nil, 
            specifiers: [],
            source: nil
end 