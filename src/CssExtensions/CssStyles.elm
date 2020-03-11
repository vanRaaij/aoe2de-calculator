module CssExtensions.CssStyles exposing
    ( global
    , gridContainer
    , mainContent
    , sidebar
    , smallText
    )

import Css
    exposing
        ( Px
        , Style
        , backgroundColor
        , batch
        , fixed
        , fontSize
        , height
        , left
        , marginLeft
        , padding
        , pct
        , position
        , property
        , px
        , rgb
        , small
        , textAlign
        , width
        )


global : Style
global =
    batch [ textAlign left ]


sidebarWidth : Float
sidebarWidth =
    380


sidebarPadding : Float
sidebarPadding =
    10


gridContainer : Style
gridContainer =
    batch
        [ property "display" "grid"
        , property "grid-template-columns" "1fr"
        , property "grid-template-rows" "100%"
        , property "grid-template-areas"
            """
            "main-content"
            """
        , property "place-items" "stretch"
        ]


mainContent : Style
mainContent =
    batch
        [ marginLeft (px (sidebarWidth + 2 * sidebarPadding))
        , width (pct 100)
        ]


sidebar : Style
sidebar =
    batch
        [ padding (px sidebarPadding)
        , position fixed
        , height (pct 100)
        , width (px sidebarWidth)
        , backgroundColor (rgb 250 172 151)
        ]


smallText : Style
smallText =
    fontSize small
