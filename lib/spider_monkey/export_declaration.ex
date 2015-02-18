defmodule SpiderMonkey.ExportDeclaration do
  @type t :: %SpiderMonkey.ExportDeclaration{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil,
    declaration: SpiderMonkey.Declaration.t,
    specifiers: [SpiderMonkey.ExportSpecifier.t],
    default: boolean,
    source: SpiderMonkey.Identifier.t | nil
  }
  defstruct type: "ExportDeclaration", 
            loc: nil, 
            declaration: %SpiderMonkey.EmptyStatement{},
            specifiers: nil,
            default: false,
            source: nil
end 