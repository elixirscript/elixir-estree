defmodule ESTree.Node do
  @type t ::  ESTree.Program.t | 
              ESTree.Function.t | 
              ESTree.Statement.t |
              ESTree.VariableDeclarator.t |
              ESTree.Expression.t |
              ESTree.Property.t |
              ESTree.Pattern.t |
              ESTree.SwitchCase.t |
              ESTree.CatchClause.t |
              ESTree.Identifier.t |
              ESTree.Literal.t |
              ESTree.MethodDefinition.t |
              ESTree.Class.t |
              ESTree.ClassBody.t |
              ESTree.ImportSpecifier.t |
              ESTree.ImportNamespaceSpecifier.t |
              ESTree.ExportSpecifier.t
end 