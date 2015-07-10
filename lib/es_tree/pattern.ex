defmodule ESTree.Pattern do
  @type t ::  ESTree.Expression.t | 
              ESTree.ObjectPattern.t |
              ESTree.ArrayPattern.t |
              ESTree.Identifier.t |
              ESTree.AssignmentPattern.t
end 
