defmodule SpiderMonkey.Statement do
  @type t ::  SpiderMonkey.EmptyStatement.t | 
              SpiderMonkey.BlockStatement.t |
              SpiderMonkey.ExpressionStatement.t |
              SpiderMonkey.IfStatement.t |
              SpiderMonkey.LabeledStatement.t |
              SpiderMonkey.BreakStatement.t |
              SpiderMonkey.ContinueStatement.t |
              SpiderMonkey.WithStatement.t |
              SpiderMonkey.SwitchStatement.t |
              SpiderMonkey.ReturnStatement.t |
              SpiderMonkey.ThrowStatement.t |
              SpiderMonkey.TryStatement.t |
              SpiderMonkey.WhileStatement.t |
              SpiderMonkey.DoWhileStatement.t |
              SpiderMonkey.ForStatement.t |
              SpiderMonkey.ForInStatement.t |
              SpiderMonkey.ForOfStatement.t |
              SpiderMonkey.LetStatement.t |
              SpiderMonkey.DebuggerStatement.t |
              SpiderMonkey.Declaration.t
end 