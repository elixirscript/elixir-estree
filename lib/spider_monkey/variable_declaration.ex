defmodule SpiderMonkey.VariableDeclaration do
  @type t :: %SpiderMonkey.VariableDeclaration{ 
    type: binary, 
    loc: SpiderMonkey.SourceLocation.t | nil,
    declarations: [SpiderMonkey.VariableDeclarator.t],
    kind: :var | :let | :const
  }
  defstruct type: "VariableDeclaration", 
            loc: nil,
            declarations: [],
            kind: :var
end 