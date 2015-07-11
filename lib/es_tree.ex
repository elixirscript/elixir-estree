defmodule ESTree do
  @moduledoc """
  Defines structs that represent the ESTree AST definitions. Also includes a JavaScript AST to JavaScript code generator.

  [ESTree Spec](https://github.com/estree/estree)
  """

  @type unary_operator  ::  :- | :+ | :! | :"~" | :typeof | :void | :delete

  @type binary_operator ::  :== | :!= | :=== | :!== | :< | :<= | :> | :>= | 
                            :"<<" | :">>" | :>>> | :+ | :- | :* | :/ | :% | :| | 
                            :^ | :& | :in | :instanceof

  @type logical_operator  ::  :|| | :&&

  @type assignment_operator  :: := | :"+=" | :"-=" | :"*=" | :"/=" | :"%=" | 
                                :"<<=" | :">>=" | :">>>=" | 
                                :"|=" | :"^=" | :"&="

  @type update_operator  ::  :++ | :--
end
