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
              ESTree.ImportDeclaration.t |
              ESTree.ImportSpecifier.t |
              ESTree.ImportDefaultSpecifier.t |
              ESTree.ImportNamespaceSpecifier.t |
              ESTree.ExportNamedDeclaration.t |
              ESTree.ExportSpecifier.t |
              ESTree.ExportDefaultDeclaration.t |
              ESTree.ExportAllDeclaration.t |
              ESTree.TemplateElement.t |
              ESTree.Super.t
end 
