defmodule ESTree.Statement do
  @type t ::  ESTree.EmptyStatement.t | 
              ESTree.BlockStatement.t |
              ESTree.ExpressionStatement.t |
              ESTree.IfStatement.t |
              ESTree.LabeledStatement.t |
              ESTree.BreakStatement.t |
              ESTree.ContinueStatement.t |
              ESTree.WithStatement.t |
              ESTree.SwitchStatement.t |
              ESTree.ReturnStatement.t |
              ESTree.ThrowStatement.t |
              ESTree.TryStatement.t |
              ESTree.WhileStatement.t |
              ESTree.DoWhileStatement.t |
              ESTree.ForStatement.t |
              ESTree.ForInStatement.t |
              ESTree.ForOfStatement.t |
              ESTree.DebuggerStatement.t |
              ESTree.ConditionalStatement.t |
              ESTree.Declaration.t
end 