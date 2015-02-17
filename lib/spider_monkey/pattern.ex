defmodule SpiderMonkey.Pattern do
  @type t ::  SpiderMonkey.Expression.t | 
              SpiderMonkey.ObjectPattern.t |
              SpiderMonkey.ArrayPattern.t |
              SpiderMonkey.Identifier.t
end 