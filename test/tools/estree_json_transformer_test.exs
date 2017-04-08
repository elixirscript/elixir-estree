defmodule ESTree.Tools.ESTreeJSONTransformer.Test do
  use ExUnit.Case, async: true

  alias ESTree.Tools.ESTreeJSONTransformer, as: EJT
  

  test "convert json to structs" do
    map = json() |> Poison.decode!
    structs = EJT.convert(map)

    assert structs.type === "Program"
  end


  def json() do
    """
    {
  "type": "Program",
  "start": 0,
  "end": 215,
  "range": [
    0,
    215
  ],
  "body": [
    {
      "type": "FunctionDeclaration",
      "start": 0,
      "end": 215,
      "range": [
        0,
        215
      ],
      "id": {
        "type": "Identifier",
        "start": 9,
        "end": 17,
        "range": [
          9,
          17
        ],
        "name": "fizzBuzz"
      },
      "generator": false,
      "expression": false,
      "params": [],
      "body": {
        "type": "BlockStatement",
        "start": 19,
        "end": 215,
        "range": [
          19,
          215
        ],
        "body": [
          {
            "type": "ForStatement",
            "start": 22,
            "end": 213,
            "range": [
              22,
              213
            ],
            "init": {
              "type": "VariableDeclaration",
              "start": 26,
              "end": 33,
              "range": [
                26,
                33
              ],
              "declarations": [
                {
                  "type": "VariableDeclarator",
                  "start": 30,
                  "end": 33,
                  "range": [
                    30,
                    33
                  ],
                  "id": {
                    "type": "Identifier",
                    "start": 30,
                    "end": 31,
                    "range": [
                      30,
                      31
                    ],
                    "name": "i"
                  },
                  "init": {
                    "type": "Literal",
                    "start": 32,
                    "end": 33,
                    "range": [
                      32,
                      33
                    ],
                    "value": 1,
                    "raw": "1"
                  }
                }
              ],
              "kind": "var"
            },
            "test": {
              "type": "BinaryExpression",
              "start": 34,
              "end": 40,
              "range": [
                34,
                40
              ],
              "left": {
                "type": "Identifier",
                "start": 34,
                "end": 35,
                "range": [
                  34,
                  35
                ],
                "name": "i"
              },
              "operator": "<=",
              "right": {
                "type": "Literal",
                "start": 37,
                "end": 40,
                "range": [
                  37,
                  40
                ],
                "value": 100,
                "raw": "100"
              }
            },
            "update": {
              "type": "UpdateExpression",
              "start": 41,
              "end": 44,
              "range": [
                41,
                44
              ],
              "operator": "++",
              "prefix": false,
              "argument": {
                "type": "Identifier",
                "start": 41,
                "end": 42,
                "range": [
                  41,
                  42
                ],
                "name": "i"
              }
            },
            "body": {
              "type": "BlockStatement",
              "start": 45,
              "end": 213,
              "range": [
                45,
                213
              ],
              "body": [
                {
                  "type": "IfStatement",
                  "start": 49,
                  "end": 210,
                  "range": [
                    49,
                    210
                  ],
                  "test": {
                    "type": "LogicalExpression",
                    "start": 52,
                    "end": 74,
                    "range": [
                      52,
                      74
                    ],
                    "left": {
                      "type": "BinaryExpression",
                      "start": 52,
                      "end": 61,
                      "range": [
                        52,
                        61
                      ],
                      "left": {
                        "type": "BinaryExpression",
                        "start": 52,
                        "end": 55,
                        "range": [
                          52,
                          55
                        ],
                        "left": {
                          "type": "Identifier",
                          "start": 52,
                          "end": 53,
                          "range": [
                            52,
                            53
                          ],
                          "name": "i"
                        },
                        "operator": "%",
                        "right": {
                          "type": "Literal",
                          "start": 54,
                          "end": 55,
                          "range": [
                            54,
                            55
                          ],
                          "value": 5,
                          "raw": "5"
                        }
                      },
                      "operator": "===",
                      "right": {
                        "type": "Literal",
                        "start": 60,
                        "end": 61,
                        "range": [
                          60,
                          61
                        ],
                        "value": 0,
                        "raw": "0"
                      }
                    },
                    "operator": "&&",
                    "right": {
                      "type": "BinaryExpression",
                      "start": 65,
                      "end": 74,
                      "range": [
                        65,
                        74
                      ],
                      "left": {
                        "type": "BinaryExpression",
                        "start": 65,
                        "end": 68,
                        "range": [
                          65,
                          68
                        ],
                        "left": {
                          "type": "Identifier",
                          "start": 65,
                          "end": 66,
                          "range": [
                            65,
                            66
                          ],
                          "name": "i"
                        },
                        "operator": "%",
                        "right": {
                          "type": "Literal",
                          "start": 67,
                          "end": 68,
                          "range": [
                            67,
                            68
                          ],
                          "value": 3,
                          "raw": "3"
                        }
                      },
                      "operator": "===",
                      "right": {
                        "type": "Literal",
                        "start": 73,
                        "end": 74,
                        "range": [
                          73,
                          74
                        ],
                        "value": 0,
                        "raw": "0"
                      }
                    }
                  },
                  "consequent": {
                    "type": "BlockStatement",
                    "start": 75,
                    "end": 102,
                    "range": [
                      75,
                      102
                    ],
                    "body": [
                      {
                        "type": "ExpressionStatement",
                        "start": 80,
                        "end": 98,
                        "range": [
                          80,
                          98
                        ],
                        "expression": {
                          "type": "CallExpression",
                          "start": 80,
                          "end": 97,
                          "range": [
                            80,
                            97
                          ],
                          "callee": {
                            "type": "Identifier",
                            "start": 80,
                            "end": 85,
                            "range": [
                              80,
                              85
                            ],
                            "name": "print"
                          },
                          "arguments": [
                            {
                              "type": "Literal",
                              "start": 86,
                              "end": 96,
                              "range": [
                                86,
                                96
                              ],
                              "value": "FizzBuzz",
                              "raw": "'FizzBuzz'"
                            }
                          ]
                        }
                      }
                    ]
                  },
                  "alternate": {
                    "type": "IfStatement",
                    "start": 108,
                    "end": 210,
                    "range": [
                      108,
                      210
                    ],
                    "test": {
                      "type": "BinaryExpression",
                      "start": 111,
                      "end": 120,
                      "range": [
                        111,
                        120
                      ],
                      "left": {
                        "type": "BinaryExpression",
                        "start": 111,
                        "end": 114,
                        "range": [
                          111,
                          114
                        ],
                        "left": {
                          "type": "Identifier",
                          "start": 111,
                          "end": 112,
                          "range": [
                            111,
                            112
                          ],
                          "name": "i"
                        },
                        "operator": "%",
                        "right": {
                          "type": "Literal",
                          "start": 113,
                          "end": 114,
                          "range": [
                            113,
                            114
                          ],
                          "value": 3,
                          "raw": "3"
                        }
                      },
                      "operator": "===",
                      "right": {
                        "type": "Literal",
                        "start": 119,
                        "end": 120,
                        "range": [
                          119,
                          120
                        ],
                        "value": 0,
                        "raw": "0"
                      }
                    },
                    "consequent": {
                      "type": "BlockStatement",
                      "start": 121,
                      "end": 144,
                      "range": [
                        121,
                        144
                      ],
                      "body": [
                        {
                          "type": "ExpressionStatement",
                          "start": 126,
                          "end": 140,
                          "range": [
                            126,
                            140
                          ],
                          "expression": {
                            "type": "CallExpression",
                            "start": 126,
                            "end": 139,
                            "range": [
                              126,
                              139
                            ],
                            "callee": {
                              "type": "Identifier",
                              "start": 126,
                              "end": 131,
                              "range": [
                                126,
                                131
                              ],
                              "name": "print"
                            },
                            "arguments": [
                              {
                                "type": "Literal",
                                "start": 132,
                                "end": 138,
                                "range": [
                                  132,
                                  138
                                ],
                                "value": "Fizz",
                                "raw": "'Fizz'"
                              }
                            ]
                          }
                        }
                      ]
                    },
                    "alternate": {
                      "type": "IfStatement",
                      "start": 150,
                      "end": 210,
                      "range": [
                        150,
                        210
                      ],
                      "test": {
                        "type": "BinaryExpression",
                        "start": 153,
                        "end": 162,
                        "range": [
                          153,
                          162
                        ],
                        "left": {
                          "type": "BinaryExpression",
                          "start": 153,
                          "end": 156,
                          "range": [
                            153,
                            156
                          ],
                          "left": {
                            "type": "Identifier",
                            "start": 153,
                            "end": 154,
                            "range": [
                              153,
                              154
                            ],
                            "name": "i"
                          },
                          "operator": "%",
                          "right": {
                            "type": "Literal",
                            "start": 155,
                            "end": 156,
                            "range": [
                              155,
                              156
                            ],
                            "value": 5,
                            "raw": "5"
                          }
                        },
                        "operator": "===",
                        "right": {
                          "type": "Literal",
                          "start": 161,
                          "end": 162,
                          "range": [
                            161,
                            162
                          ],
                          "value": 0,
                          "raw": "0"
                        }
                      },
                      "consequent": {
                        "type": "BlockStatement",
                        "start": 163,
                        "end": 186,
                        "range": [
                          163,
                          186
                        ],
                        "body": [
                          {
                            "type": "ExpressionStatement",
                            "start": 168,
                            "end": 182,
                            "range": [
                              168,
                              182
                            ],
                            "expression": {
                              "type": "CallExpression",
                              "start": 168,
                              "end": 181,
                              "range": [
                                168,
                                181
                              ],
                              "callee": {
                                "type": "Identifier",
                                "start": 168,
                                "end": 173,
                                "range": [
                                  168,
                                  173
                                ],
                                "name": "print"
                              },
                              "arguments": [
                                {
                                  "type": "Literal",
                                  "start": 174,
                                  "end": 180,
                                  "range": [
                                    174,
                                    180
                                  ],
                                  "value": "Buzz",
                                  "raw": "'Buzz'"
                                }
                              ]
                            }
                          }
                        ]
                      },
                      "alternate": {
                        "type": "BlockStatement",
                        "start": 192,
                        "end": 210,
                        "range": [
                          192,
                          210
                        ],
                        "body": [
                          {
                            "type": "ExpressionStatement",
                            "start": 197,
                            "end": 206,
                            "range": [
                              197,
                              206
                            ],
                            "expression": {
                              "type": "CallExpression",
                              "start": 197,
                              "end": 205,
                              "range": [
                                197,
                                205
                              ],
                              "callee": {
                                "type": "Identifier",
                                "start": 197,
                                "end": 202,
                                "range": [
                                  197,
                                  202
                                ],
                                "name": "print"
                              },
                              "arguments": [
                                {
                                  "type": "Identifier",
                                  "start": 203,
                                  "end": 204,
                                  "range": [
                                    203,
                                    204
                                  ],
                                  "name": "i"
                                }
                              ]
                            }
                          }
                        ]
                      }
                    }
                  }
                }
              ]
            }
          }
        ]
      }
    }
  ],
  "sourceType": "module"
}  
    """
  end
end