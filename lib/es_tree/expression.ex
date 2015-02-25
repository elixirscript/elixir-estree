defmodule ESTree.Expression do
  @type t ::  ESTree.ThisExpression.t | 
              ESTree.ArrayExpression.t |
              ESTree.ObjectExpression.t |
              ESTree.FunctionExpression.t |
              ESTree.ArrowFunctionExpression.t |
              ESTree.SequenceExpression.t |
              ESTree.UnaryExpression.t |
              ESTree.BinaryExpression.t |
              ESTree.AssignmentExpression.t |
              ESTree.UpdateExpression.t |
              ESTree.LogicalExpression.t |
              ESTree.ConditionalExpression.t |
              ESTree.NewExpression.t |
              ESTree.CallExpression.t |
              ESTree.MemberExpression.t |
              ESTree.YieldExpression.t |
              ESTree.Identifier.t |
              ESTree.Literal.t |
              ESTree.ClassExpression.t |
              ESTree.TemplateLiteral.t |
              ESTree.TaggedTemplateExpression.t
end 