module Resources exposing
    ( Cost
    , applyToFood
    , applyToGold
    , applyToStone
    , applyToTime
    , applyToWood
    , food
    , gold
    , stone
    , time
    , withCostOf
    , wood
    )


type alias Resources =
    { food : Int
    , wood : Int
    , stone : Int
    , gold : Int
    }


type alias Cost =
    { resources : Resources
    , buildTime : Float
    }


withCostOf : Cost
withCostOf =
    cost0


food : Int -> Cost -> Cost
food f { resources, buildTime } =
    let
        newResources =
            { resources | food = f }
    in
    Cost newResources buildTime


wood : Int -> Cost -> Cost
wood w { resources, buildTime } =
    let
        newResources =
            { resources | wood = w }
    in
    Cost newResources buildTime


stone : Int -> Cost -> Cost
stone s { resources, buildTime } =
    let
        newResources =
            { resources | stone = s }
    in
    Cost newResources buildTime


gold : Int -> Cost -> Cost
gold g { resources, buildTime } =
    let
        newResources =
            { resources | gold = g }
    in
    Cost newResources buildTime


time : Float -> Cost -> Cost
time t c =
    { c | buildTime = t }


applyToFood : (Int -> Int) -> Cost -> Cost
applyToFood f { resources, buildTime } =
    let
        newResources =
            { resources | food = f resources.food }
    in
    Cost newResources buildTime


applyToWood : (Int -> Int) -> Cost -> Cost
applyToWood f { resources, buildTime } =
    let
        newResources =
            { resources | wood = f resources.wood }
    in
    Cost newResources buildTime


applyToStone : (Int -> Int) -> Cost -> Cost
applyToStone f { resources, buildTime } =
    let
        newResources =
            { resources | stone = f resources.stone }
    in
    Cost newResources buildTime


applyToGold : (Int -> Int) -> Cost -> Cost
applyToGold f { resources, buildTime } =
    let
        newResources =
            { resources | gold = f resources.gold }
    in
    Cost newResources buildTime


applyToTime : (Float -> Float) -> Cost -> Cost
applyToTime f { resources, buildTime } =
    Cost resources <| f buildTime


cost0 : Cost
cost0 =
    { resources =
        { food = 0
        , wood = 0
        , stone = 0
        , gold = 0
        }
    , buildTime = 0
    }
