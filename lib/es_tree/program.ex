defmodule ESTree.Program do
  @type t :: %ESTree.Program{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil, 
    body: [ESTree.Statement.t ],
    sourceType: :script | :module
  }
  defstruct type: "Program", loc: nil, body: [], sourceType: :module
end
