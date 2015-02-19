defmodule SpiderMonkey.Builder do
  @moduledoc """
  Functions for building the SpiderMonkey nodes 
  """

  @spec to_json(SpiderMonkey.Node.t) :: binary
  def to_json(node) do
    Poison.encode!(node)
  end

  @spec array_expression(
    [SpiderMonkey.Expression.t | nil], 
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.ArrayExpression.t
  def array_expression(elements, loc \\ nil) do
    %SpiderMonkey.ArrayExpression{ elements: elements, loc: loc }
  end 

  @spec array_pattern(
    [SpiderMonkey.Pattern.t | nil], 
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.ArrayPattern.t
  def array_pattern(elements, loc \\ nil) do
    %SpiderMonkey.ArrayPattern{ elements: elements, loc: loc }
  end 

  @spec arrow_expression(
    [SpiderMonkey.Pattern.t], 
    [ SpiderMonkey.Expression.t ], 
    SpiderMonkey.Identifier.t | nil, 
    SpiderMonkey.BlockStatement.t | SpiderMonkey.Expression.t,
    boolean,
    boolean,
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.ArrowExpression.t
  def arrow_expression(params, defaults, body, rest \\ nil, generator \\ false, expression \\ false, loc \\ nil) do
    %SpiderMonkey.ArrowExpression{ 
      params: params, defaults: defaults, rest: rest, 
      body: body, generator: generator, expression: expression, loc: loc 
    }
  end 

  @spec assignment_expression(
    SpiderMonkey.assignment_operator, 
    SpiderMonkey.Pattern.t | SpiderMonkey.Expression.t, 
    SpiderMonkey.Expression.t,
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.AssignmentExpression.t
  def assignment_expression(operator, left, right, loc \\ nil) do
    %SpiderMonkey.AssignmentExpression{ 
      operator: operator, left: left, right: right, loc: loc
    }
  end

  @spec binary_expression(
    SpiderMonkey.binary_operator, 
    SpiderMonkey.Expression.t, 
    SpiderMonkey.Expression.t,
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.BinaryExpression.t
  def binary_expression(operator, left, right, loc \\ nil) do
    %SpiderMonkey.BinaryExpression{ 
      operator: operator, left: left, right: right, loc: loc
    }
  end

  @spec block_statement(
    [SpiderMonkey.Statement.t],
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.BlockStatement.t
  def block_statement(body, loc \\ nil) do
    %SpiderMonkey.BlockStatement{ 
      body: body, loc: loc
    }
  end

  @spec break_statement(
    SpiderMonkey.Identifier.t | nil,
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.BreakStatement.t
  def break_statement(label, loc \\ nil) do
    %SpiderMonkey.BreakStatement{ 
      label: label, loc: loc
    }
  end 

  @spec call_expression(
    SpiderMonkey.Expression.t,
    [SpiderMonkey.Expression.t],
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.CallExpression.t
  def call_expression(callee, arguments, loc \\ nil) do
    %SpiderMonkey.CallExpression{ 
      callee: callee, arguments: arguments, loc: loc
    }
  end 

  @spec catch_clause(
    SpiderMonkey.Pattern.t,
    SpiderMonkey.BlockStatement.t,
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.CatchClause.t
  def catch_clause(param, body, loc \\ nil) do
    %SpiderMonkey.CatchClause{ 
      param: param, body: body, loc: loc
    }
  end 

  @spec class_body(
    [SpiderMonkey.MethodDefinition.t],
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.ClassBody.t
  def class_body(body, loc \\ nil) do
    %SpiderMonkey.ClassBody{ 
      body: body, loc: loc
    }
  end 

  @spec class_declaration(
    SpiderMonkey.Identifier.t,
    SpiderMonkey.ClassBody.t,
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.ClassDeclaration.t
  def class_declaration(id, body, loc \\ nil) do
    %SpiderMonkey.ClassDeclaration{ 
      id: id, body: body, loc: loc
    }
  end  

  @spec class_expression(
    SpiderMonkey.ClassBody.t,
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.ClassExpression.t
  def class_expression(body, loc \\ nil) do
    %SpiderMonkey.ClassExpression{ 
      body: body, loc: loc
    }
  end 

  @spec conditional_statement(
    SpiderMonkey.Expression.t,
    SpiderMonkey.Expression.t,
    SpiderMonkey.Expression.t,
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.ConditionalStatement.t
  def conditional_statement(test, alternate, consequent, loc \\ nil) do
    %SpiderMonkey.ConditionalStatement{ 
      test: test, alternate: alternate, consequent: consequent, loc: loc
    }
  end

  @spec continue_statement(
    SpiderMonkey.Identifier.t,
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.ContinueStatement.t
  def continue_statement(label, loc \\ nil) do
    %SpiderMonkey.ContinueStatement{ 
      label: label, loc: loc
    }
  end 

  @spec debugger_statement(
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.DebuggerStatement.t
  def debugger_statement(loc \\ nil) do
    %SpiderMonkey.DebuggerStatement{ 
      loc: loc
    }
  end

  @spec do_while_statement(
    SpiderMonkey.Statement.t,
    SpiderMonkey.Expression.t,
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.DoWhileStatement.t
  def do_while_statement(body, test, loc \\ nil) do
    %SpiderMonkey.DoWhileStatement{ 
      body: body, test: test, loc: loc
    }
  end

  @spec empty_expression(
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.EmptyExpression.t
  def empty_expression(loc \\ nil) do
    %SpiderMonkey.EmptyExpression{ 
      loc: loc
    }
  end 

  @spec empty_statement(
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.EmptyStatement.t
  def empty_statement(loc \\ nil) do
    %SpiderMonkey.EmptyStatement{ 
      loc: loc
    }
  end

  @spec export_declaration(
    SpiderMonkey.Declaration.t,
    [SpiderMonkey.ExportSpecifier.t],
    boolean,
    SpiderMonkey.Identifier.t | nil,
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.ExportDeclaration.t
  def export_declaration(declaration, specifiers \\ [], default \\ false, source \\ nil, loc \\ nil) do
    %SpiderMonkey.ExportDeclaration{ 
      declaration: declaration, specifiers: specifiers, default: default, source: source, loc: loc
    }
  end

  #TODO: Figure out what the structure for this looks like
  @spec export_specifier(
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.ExportSpecifier.t
  def export_specifier(loc \\ nil) do
    %SpiderMonkey.ExportSpecifier{ 
      loc: loc
    }
  end

  @spec expression_statement(
    SpiderMonkey.Expression.t,
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.ExpressionStatement.t
  def expression_statement(expression, loc \\ nil) do
    %SpiderMonkey.ExpressionStatement{ 
      expression: expression, loc: loc
    }
  end

  @spec for_in_statement(
    SpiderMonkey.VariableDeclaration.t | SpiderMonkey.Expression.t,
    SpiderMonkey.Expression.t,
    SpiderMonkey.Statement.t,
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.ForInStatement.t
  def for_in_statement(left, right, body, loc \\ nil) do
    %SpiderMonkey.ForInStatement{ 
      left: left, right: right, body: body, loc: loc
    }
  end

  @spec for_of_statement(
    SpiderMonkey.VariableDeclaration.t | SpiderMonkey.Expression.t,
    SpiderMonkey.Expression.t,
    SpiderMonkey.Statement.t,
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.ForOfStatement.t
  def for_of_statement(left, right, body, loc \\ nil) do
    %SpiderMonkey.ForOfStatement{ 
      left: left, right: right, body: body, loc: loc
    }
  end

  @spec for_statement(
    SpiderMonkey.VariableDeclaration.t | SpiderMonkey.Expression.t,
    SpiderMonkey.Expression.t | nil,
    SpiderMonkey.Expression.t | nil,
    SpiderMonkey.Statement.t,
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.ForStatement.t
  def for_statement(init, test, update, body, loc \\ nil) do
    %SpiderMonkey.ForStatement{ 
      init: init, test: test, update: update, body: body, loc: loc
    }
  end

  @spec function_declaration(
    SpiderMonkey.Identifier.t,
    [SpiderMonkey.Pattern.t], 
    [ SpiderMonkey.Expression.t ], 
    SpiderMonkey.Identifier.t | nil, 
    SpiderMonkey.BlockStatement.t,
    boolean,
    boolean,
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.FunctionDeclaration.t
  def function_declaration(id, params, defaults, body, rest \\ nil, generator \\ false, expression \\ false, loc \\ nil) do
    %SpiderMonkey.FunctionDeclaration{ 
      id: id, params: params, defaults: defaults, rest: rest, 
      body: body, generator: generator, expression: expression, loc: loc 
    }
  end 

  @spec function_expression(
    [SpiderMonkey.Pattern.t], 
    [ SpiderMonkey.Expression.t ], 
    SpiderMonkey.Identifier.t | nil, 
    SpiderMonkey.BlockStatement.t,
    boolean,
    boolean,
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.FunctionExpression.t
  def function_expression(params, defaults, body, rest \\ nil, generator \\ false, expression \\ false, loc \\ nil) do
    %SpiderMonkey.FunctionExpression{ 
      params: params, defaults: defaults, rest: rest, 
      body: body, generator: generator, expression: expression, loc: loc 
    }
  end 

  @spec identifier(
    binary,
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.Identifier.t
  def identifier(name, loc \\ nil) do
    %SpiderMonkey.Identifier{ 
      name: name, loc: loc
    }
  end

  @spec if_statement(
    SpiderMonkey.Expression.t,
    SpiderMonkey.Statement.t,
    SpiderMonkey.Statement.t | nil,
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.IfStatement.t
  def if_statement(test, consequent, alternate \\ nil, loc \\ nil) do
    %SpiderMonkey.IfStatement{ 
      test: test, consequent: consequent, alternate: alternate, loc: loc
    }
  end

  @spec import_declaration(
    [SpiderMonkey.ImportSpecifier.t],
    SpiderMonkey.Identifier.t | nil,
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.ImportDeclaration.t
  def import_declaration(specifiers, source \\ nil, loc \\ nil) do
    %SpiderMonkey.ImportDeclaration{ 
      specifiers: specifiers, source: source, loc: loc
    }
  end

  @spec import_specifier(
    SpiderMonkey.Identifier.t,
    SpiderMonkey.Identifier.t | nil,
    boolean,
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.ImportSpecifier.t
  def import_specifier(id, name \\ nil, default \\ false, loc \\ nil) do
    %SpiderMonkey.ImportSpecifier{ 
      id: id, name: name, default: default, loc: loc
    }
  end

  @spec labeled_statement(
    SpiderMonkey.Identifier.t,
    SpiderMonkey.Statement.t,
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.LabeledStatement.t
  def labeled_statement(label, body, loc \\ nil) do
    %SpiderMonkey.LabeledStatement{ 
      label: label, body: body, loc: loc
    }
  end

  @spec literal(
    binary | boolean | number | nil,
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.Literal.t
  def literal(value, loc \\ nil) do
    %SpiderMonkey.Literal{ 
      value: value, loc: loc
    }
  end

  @spec logical_expression(
    SpiderMonkey.logical_operator, 
    SpiderMonkey.Expression.t, 
    SpiderMonkey.Expression.t,
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.LogicalExpression.t
  def logical_expression(operator, left, right, loc \\ nil) do
    %SpiderMonkey.LogicalExpression{ 
      operator: operator, left: left, right: right, loc: loc
    }
  end

  @spec member_expression(
    SpiderMonkey.Expression.t, 
    SpiderMonkey.Identifier.t | SpiderMonkey.Expression.t,
    boolean,
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.MemberExpression.t
  def member_expression(object, property, computed \\ false, loc \\ nil) do
    %SpiderMonkey.MemberExpression{ 
      object: object, property: property, computed: computed, loc: loc
    }
  end

  @spec method_definition(
    SpiderMonkey.Identifier.t, 
    SpiderMonkey.FunctionExpression.t,
    :"" | :get | :set,
    boolean,
    boolean,
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.MethodDefinition.t
  def method_definition(key, value, kind \\ :"", computed \\ false, static \\ false, loc \\ nil) do
    %SpiderMonkey.MethodDefinition{ 
      key: key, value: value, kind: kind, computed: computed, static: static, loc: loc
    }
  end

  @spec new_expression(
    SpiderMonkey.Expression.t,
    [SpiderMonkey.Expression.t],
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.NewExpression.t
  def new_expression(callee, arguments, loc \\ nil) do
    %SpiderMonkey.NewExpression{ 
      callee: callee, arguments: arguments, loc: loc
    }
  end

  @spec object_expression(
    [SpiderMonkey.Property.t],
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.ObjectExpression.t
  def object_expression(properties, loc \\ nil) do
    %SpiderMonkey.ObjectExpression{ 
      properties: properties, loc: loc
    }
  end 

  @spec object_pattern(
    [SpiderMonkey.ObjectPatternProperty.t],
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.ObjectPattern.t
  def object_pattern(properties, loc \\ nil) do
    %SpiderMonkey.ObjectPattern{ 
      properties: properties, loc: loc
    }
  end 

  @spec object_pattern_property(
    SpiderMonkey.Literal.t | SpiderMonkey.Identifier.t,
    SpiderMonkey.Pattern.t
  ) :: SpiderMonkey.ObjectPatternProperty.t
  def object_pattern_property(key, value) do
    %SpiderMonkey.ObjectPatternProperty{ 
      key: key, value: value
    }
  end

  @spec position(
    pos_integer,
    non_neg_integer
  ) :: SpiderMonkey.Position.t
  def position(line, column) do
    %SpiderMonkey.Position{ 
      line: line, column: column
    }
  end

  @spec program(
    [SpiderMonkey.Statement.t ],
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.Program.t
  def program(body, loc \\ nil) do
    %SpiderMonkey.Program{ 
      body: body, loc: loc
    }
  end

  @spec property(
    SpiderMonkey.Literal.t | SpiderMonkey.Identifier.t, 
    SpiderMonkey.Expression.t ,
    :init | :get | :set,
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.Property.t
  def property(key, value, kind \\ :init, loc \\ nil) do
    %SpiderMonkey.Property{ 
      key: key, value: value, kind: kind, loc: loc
    }
  end

  @spec return_statement(
    SpiderMonkey.Expression.t | nil,
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.ReturnStatement.t
  def return_statement(argument, loc \\ nil) do
    %SpiderMonkey.ReturnStatement{ 
      argument: argument, loc: loc
    }
  end

  @spec sequence_expression(
    [SpiderMonkey.Expression.t],
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.SequenceExpression.t
  def sequence_expression(expressions, loc \\ nil) do
    %SpiderMonkey.SequenceExpression{ 
      expressions: expressions, loc: loc
    }
  end

  @spec source_location(
    binary | nil,
    SpiderMonkey.Position.t,
    SpiderMonkey.Position.t
  ) :: SpiderMonkey.SourceLocation.t
  def source_location(source, start, the_end) do
    %SpiderMonkey.SourceLocation{ 
      source: source, start: start, end: the_end
    }
  end

  @spec switch_case(
    SpiderMonkey.Expression.t | nil,
    [SpiderMonkey.Statement.t],
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.SwitchCase.t
  def switch_case(test, consequent, loc \\ nil) do
    %SpiderMonkey.SwitchCase{ 
      test: test, consequent: consequent, loc: loc
    }
  end

  @spec switch_statement(
    SpiderMonkey.Expression.t,
    [SpiderMonkey.SwitchCase.t],
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.SwitchStatement.t
  def switch_statement(discriminant, cases, loc \\ nil) do
    %SpiderMonkey.SwitchStatement{ 
      discriminant: discriminant, cases: cases, loc: loc
    }
  end

  @spec this_expression(
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.ThisExpression.t
  def this_expression(loc \\ nil) do
    %SpiderMonkey.ThisExpression{ 
      loc: loc
    }
  end

  @spec throw_statement(
    SpiderMonkey.Expression.t,
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.ThrowStatement.t
  def throw_statement(argument, loc \\ nil) do
    %SpiderMonkey.ThrowStatement{ 
      argument: argument, loc: loc
    }
  end

  @spec try_statement(
    SpiderMonkey.BlockStatement.t,
    SpiderMonkey.CaseClause.t | nil,
    [SpiderMonkey.CaseClause.t],
    SpiderMonkey.BlockStatement.t | nil,
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.TryStatement.t
  def try_statement(block, handler, guardedHandlers, finalizer, loc \\ nil) do
    %SpiderMonkey.TryStatement{ 
      block: block, handler: handler, guardedHandlers: guardedHandlers, finalizer: finalizer, loc: loc
    }
  end

  @spec unary_expression(
    SpiderMonkey.unary_operator, 
    boolean, 
    SpiderMonkey.Expression.t,
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.UnaryExpression.t
  def unary_expression(operator, prefix, argument, loc \\ nil) do
    %SpiderMonkey.UnaryExpression{ 
      operator: operator, prefix: prefix, argument: argument, loc: loc
    }
  end

  @spec update_expression(
    SpiderMonkey.update_operator, 
    SpiderMonkey.Expression.t,
    boolean, 
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.UpdateExpression.t
  def update_expression(operator, argument, prefix, loc \\ nil) do
    %SpiderMonkey.UpdateExpression{ 
      operator: operator, prefix: prefix, argument: argument, loc: loc
    }
  end


  @spec variable_declaration(
    [SpiderMonkey.VariableDeclarator.t], 
    :var | :let | :const,
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.VariableDeclaration.t
  def variable_declaration(declarations, kind \\ :var, loc \\ nil) do
    %SpiderMonkey.VariableDeclaration{ 
      declarations: declarations, kind: kind, loc: loc
    }
  end

  @spec variable_declarator(
    SpiderMonkey.Pattern.t, 
    SpiderMonkey.Expression.t | nil,
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.VariableDeclarator.t
  def variable_declarator(id, init \\ nil, loc \\ nil) do
    %SpiderMonkey.VariableDeclarator{ 
      id: id, init: init, loc: loc
    }
  end

  @spec while_statement(
    SpiderMonkey.Expression.t, 
    SpiderMonkey.Statement.t,
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.WhileStatement.t
  def while_statement(test, body, loc \\ nil) do
    %SpiderMonkey.WhileStatement{ 
      test: test, body: body, loc: loc
    }
  end

  @spec with_statement(
    SpiderMonkey.Expression.t, 
    SpiderMonkey.Statement.t,
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.WithStatement.t
  def with_statement(object, body, loc \\ nil) do
    %SpiderMonkey.WithStatement{ 
      object: object, body: body, loc: loc
    }
  end

  @spec yield_expression(
    SpiderMonkey.Expression.t | nil, 
    SpiderMonkey.SourceLocation.t | nil
  ) :: SpiderMonkey.YieldExpression.t
  def yield_expression(argument \\ nil, loc \\ nil) do
    %SpiderMonkey.YieldExpression{ 
      argument: argument, loc: loc
    }
  end
end