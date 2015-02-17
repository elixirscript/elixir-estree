defmodule SpiderMonkey.Node do
  @type t ::  SpiderMonkey.Program.t | 
              SpiderMonkey.Function.t | 
              SpiderMonkey.Statement.t |
              SpiderMonkey.VariableDeclarator.t |
              SpiderMonkey.Expression.t |
              SpiderMonkey.Property.t |
              SpiderMonkey.Pattern.t |
              SpiderMonkey.SwitchCase.t |
              SpiderMonkey.CatchClause.t |
              SpiderMonkey.ComprehensionBlock.t |
              SpiderMonkey.Identifier.t |
              SpiderMonkey.Literal.t
end 