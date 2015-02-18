defmodule SpiderMonkey.Declaration do
  @type t ::  SpiderMonkey.FunctionDeclaration.t | 
              SpiderMonkey.VariableDeclaration.t |
              SpiderMonkey.ClassDeclaration.t |
              SpiderMonkey.ImportDeclaration.t |
              SpiderMonkey.ExportDeclaration.t
end 