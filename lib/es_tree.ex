defmodule ESTree do
  @moduledoc """
  Defines structs that represent the SpiderMonkey AST definitions. Mostly following the ESTree Spec. Targets ES6 definitions. Some gaps filled in from 
  what acorn produces for ES6 currently. 

  [Parser API docs](https://developer.mozilla.org/en-US/docs/Mozilla/Projects/SpiderMonkey/Parser_API)

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
