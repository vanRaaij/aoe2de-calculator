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


withCostOf : Resources
withCostOf =
    { food = 0
    , wood = 0
    , stone = 0
    , gold = 0
    }


food : Int -> Resources -> Resources
food f resources =
    { resources | food = f }


wood : Int -> Resources -> Resources
wood w resources =
    { resources | wood = w }


stone : Int -> Resources -> Resources
stone s resources =
    { resources | stone = s }


gold : Int -> Resources -> Resources
gold g resources =
    { resources | gold = g }


time : Float -> Resources -> Cost
time t r =
    Cost r t


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
