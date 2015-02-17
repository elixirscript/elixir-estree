defmodule SpiderMonkey.Position do
  @type t :: %SpiderMonkey.Position{ line: pos_integer, column: non_neg_integer }
  defstruct line: 1, column: 0
end