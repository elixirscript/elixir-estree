defmodule SpiderMonkey.Expression do
  @type t ::  SpiderMonkey.ThisExpression.t | 
              SpiderMonkey.ArrayExpression.t |
              SpiderMonkey.ObjectExpression.t |
              SpiderMonkey.FunctionExpression.t |
              SpiderMonkey.ArrowExpression.t |
              SpiderMonkey.SequenceExpression.t |
              SpiderMonkey.UnaryExpression.t |
              SpiderMonkey.BinaryExpression.t |
              SpiderMonkey.AssignmentExpression.t |
              SpiderMonkey.UpdateExpression.t |
              SpiderMonkey.LogicalExpression.t |
              SpiderMonkey.ConditionalExpression.t |
              SpiderMonkey.NewExpression.t |
              SpiderMonkey.CallExpression.t |
              SpiderMonkey.MemberExpression.t |
              SpiderMonkey.YieldExpression.t |
              SpiderMonkey.ComprehensionExpression.t |
              SpiderMonkey.GeneratorExpression.t |
              SpiderMonkey.GraphExpression.t |
              SpiderMonkey.GraphIndexExpression.t |
              SpiderMonkey.LetExpression.t |
              SpiderMonkey.Identifier.t |
              SpiderMonkey.Literal.t
end 