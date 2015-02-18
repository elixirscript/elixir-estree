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
              SpiderMonkey.Identifier.t |
              SpiderMonkey.Literal.t |
              SpiderMonkey.MethodDefinition.t |
              SpiderMonkey.Class.t |
              SpiderMonkey.ClassBody.t |
              SpiderMonkey.ImportSpecifier.t |
              SpiderMonkey.ExportSpecifier.t
end 