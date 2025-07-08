# Introduction

**AreaManager** is a **shared** squirrel scripts package which allows to create the 2d areas from any number of points.  
This package contains two files:

- area.nut
    
    The simple class which allows you to create the 2d shaped areas and check if specified point is in the area.  
    It also gives you the possibility to specify the minimum and maximum height (y coordinate) to create pseudo 3d area.

- areamanager.nut

    The manager which gives you possibility to add your area to processed areas list.  
    The processed area will check for each 500 ms if the hero/player is in the specified area.  
    It will also call the ``onEnter`` and ``onExit`` callbacks, when hero/player enters or exits specific area.  
    This script requires **ONE TIMER** to work.

## How to install?

1.Clone or download the repository source code  
2.Extract the code whenether you like in your g2o_server directory  
3.Add this line to your XML loading section  

**NOTE** That you have to edit the example paths to match with your script location.

```xml
<script src="path/to/script/area.nut" side="client" />
<script src="path/to/script/area.nut" side="server" />

<script src="path/to/script/areamanager.nut" side="client" />
<script src="path/to/script/areamanager.nut" side="server" />
```

## Usage example

### Using Area class only

```js
// client-side
local monasteryArea = Area({
    points = 
    [
        {x = 45078.16, z = 20583.71},
        {x = 46043.58, z = 18982.20},
        {x = 46671.66, z = 19360.81},
        {x = 47497.69, z = 17990.53},
        {x = 46869.62, z = 17611.92},
        {x = 47835.04, z = 16010.40},
        {x = 52353.40, z = 18734.15},
        {x = 49596.51, z = 23307.47},
    ],

    world = "NEWWORLD\\NEWWORLD.ZEN"
})

addEventHandler("onCommand", function(cmd, arg)
{
    if (cmd != "isinmonastery")
        return

    local heroPosition = getPlayerPosition(heroId)
    local heroWorld = getWorld()

    local isIn = monasteryArea.isIn(heroPosition.x, heroPosition.y, heroPosition.z, heroWorld)

    if (isIn)
        print("Hero is in monastery area!")
    else
        print("Hero isn't in monastery area!")
})
```

```js
// server-side
local monasteryArea = Area({
    points = 
    [
        {x = 45078.16, z = 20583.71},
        {x = 46043.58, z = 18982.20},
        {x = 46671.66, z = 19360.81},
        {x = 47497.69, z = 17990.53},
        {x = 46869.62, z = 17611.92},
        {x = 47835.04, z = 16010.40},
        {x = 52353.40, z = 18734.15},
        {x = 49596.51, z = 23307.47},
    ],

    world = "NEWWORLD\\NEWWORLD.ZEN"
})

addEventHandler("onPlayerCommand", function(pid, cmd, arg)
{
    if (cmd != "isinmonastery")
        return

    local playerPosition = getPlayerPosition(pid)
    local playerWorld = getPlayerWorld(pid)

    local isIn = monasteryArea.isIn(playerPosition.x, playerPosition.y, playerPosition.z, playerWorld)

    if (isIn)
        print("Player with id " + pid + " is in monastery area!")
    else
        print("Player with id " + pid + " isn't in monastery area!")
})
```

### Using Area class + AreaManager

```js
// client-side
local monasteryArea = Area({
    points = 
    [
        {x = 45078.16, z = 20583.71},
        {x = 46043.58, z = 18982.20},
        {x = 46671.66, z = 19360.81},
        {x = 47497.69, z = 17990.53},
        {x = 46869.62, z = 17611.92},
        {x = 47835.04, z = 16010.40},
        {x = 52353.40, z = 18734.15},
        {x = 49596.51, z = 23307.47},
    ],

    world = "NEWWORLD\\NEWWORLD.ZEN"
})

local function onEnter()
{
    print("You've entered monastery area!")
}

local function onExit()
{
    print("You've exited from monastery area!")
}

AreaManager.add(monasteryArea, onEnter, onExit)
```

```js
// server-side
local monasteryArea = Area({
    points = 
    [
        {x = 45078.16, z = 20583.71},
        {x = 46043.58, z = 18982.20},
        {x = 46671.66, z = 19360.81},
        {x = 47497.69, z = 17990.53},
        {x = 46869.62, z = 17611.92},
        {x = 47835.04, z = 16010.40},
        {x = 52353.40, z = 18734.15},
        {x = 49596.51, z = 23307.47},
    ],

    world = "NEWWORLD\\NEWWORLD.ZEN"
})

local function onEnter(pid)
{
    print("Player with id " + pid + " entered monastery area!")
}

local function onExit(pid)
{
   print("Player with id " + pid + " exited from monastery area!")
}

AreaManager.add(monasteryArea, onEnter, onExit)
```