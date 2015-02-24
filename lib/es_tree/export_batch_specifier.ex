defmodule ESTree.ExportBatchSpecifier do
  @type t :: %ESTree.ExportBatchSpecifier{ 
    type: binary, 
    loc: ESTree.SourceLocation.t | nil
  }
  defstruct type: "ExportBatchSpecifier", 
            loc: nil
end 