defmodule ESTree.Declaration do
  @type t ::  ESTree.FunctionDeclaration.t | 
              ESTree.VariableDeclaration.t |
              ESTree.ClassDeclaration.t |
              ESTree.ImportDeclaration.t |
              ESTree.ExportDeclaration.t
end 