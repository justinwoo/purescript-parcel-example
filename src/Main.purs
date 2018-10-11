module Main where

import Prelude

import Effect.Uncurried (mkEffectFn1)
import React.Basic as React
import React.Basic.DOM as R
foreign import foreignHMR :: React.Component ~> React.Component

type ExampleProps =
  { label :: String
  }

type ExampleState =
  { counter :: Int
  }

example :: React.Component ExampleProps
example = foreignHMR example'

example' :: React.Component ExampleProps
example' = React.component
  { displayName: "example"
  , initialState
  , receiveProps
  , render
  }
  where
    initialState :: ExampleState
    initialState = { counter: 0 }
    receiveProps _ = pure unit

    render { props, state, setState } =
      let
        hello =
          R.h1 { children: [ R.text "Hello World" ]}
        button =
          R.button
            { onClick: mkEffectFn1 \_ -> do
                setState \s -> { counter: s.counter + 1 }
            , children:
                [ R.text (props.label <> ": " <> show state.counter)
                ]
            }
      in
        R.div
          { children:
              [ hello
              , button
              ]
          }
