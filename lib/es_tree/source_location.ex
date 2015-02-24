defmodule ESTree.SourceLocation do
  @type t :: %ESTree.SourceLocation{ 
    source: binary | nil, 
    start: ESTree.Position.t, 
    end: ESTree.Position.t 
  }
  defstruct source: nil, 
            start: %ESTree.Position{}, 
            end: %ESTree.Position{}
end 