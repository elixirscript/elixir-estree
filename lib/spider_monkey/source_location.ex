defmodule SpiderMonkey.SourceLocation do
  @type t :: %SpiderMonkey.SourceLocation{ 
    source: binary | nil, 
    start: SpiderMonkey.Position.t, 
    end: SpiderMonkey.Position.t 
  }
  defstruct source: nil, 
            start: %SpiderMonkey.Position{}, 
            end: %SpiderMonkey.Position{}
end 