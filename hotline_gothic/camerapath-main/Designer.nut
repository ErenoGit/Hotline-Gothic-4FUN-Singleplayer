local FreeCamView =
{
    window = null

    inputPositionX = null
    inputPositionY = null
    inputPositionZ = null

    inputRotationX = null
    inputRotationY = null
    inputRotationZ = null

    inputMovementSpeed = null
    inputRotationSpeed = null

    buttonApply = null

    function init()
    {
        local windowWidth = anx(360)
        local marginX = anx(20), spacingX = anx(10), spacingY = any(5)
        local oneThirdWidth = windowWidth / 3 - marginX
        local inputHeight = any(12), inputSpacing = (inputHeight - spacingY) / 2
        local x = 8192 - windowWidth, y = 0

        window = GUI.Window({
            position = {x = x, y = y}
            file = "MENU_INGAME.TGA"
            disabled = true
        })

        // Title Section
        local labelTitle = GUI.Draw({
            text = "FreeCam properies"
            font = "FONT_OLD_20_WHITE.TGA"
            collection = window
        })

        x = (windowWidth - labelTitle.getSize().width) / 2, y += spacingY
        labelTitle.setRelativePosition(x, y)

        // Position Section
        local labelPosition = GUI.Draw({
            text = "Camera position:"
            collection = window
        })

        x = (windowWidth - labelPosition.getSize().width) / 2, y += labelTitle.getSize().height
        labelPosition.setRelativePosition(x, y)

        x = marginX, y += labelPosition.getSize().height + spacingY

        inputPositionX = GUI.NumberInput({
            relativePosition = {x = x, y = y}
            size = {width = oneThirdWidth, height = inputHeight}
            file = "MENU_CHOICE_BACK.TGA"
            font = "FONT_OLD_10_WHITE_HI.TGA"
            align = Align.Left
            paddingPx = 4
            collection = window
        })

        x += oneThirdWidth + spacingX

        inputPositionY = GUI.NumberInput({
            relativePosition = {x = x, y = y}
            size = {width = oneThirdWidth, height = inputHeight}
            file = "MENU_CHOICE_BACK.TGA"
            font = "FONT_OLD_10_WHITE_HI.TGA",
            align = Align.Left
            paddingPx = 4
            collection = window
        })

        x += oneThirdWidth + spacingX

        inputPositionZ = GUI.NumberInput({
            relativePosition = {x = x, y = y}
            size = {width = oneThirdWidth, height = inputHeight}
            file = "MENU_CHOICE_BACK.TGA"
            font = "FONT_OLD_10_WHITE_HI.TGA",
            align = Align.Left,
            paddingPx = 4
            collection = window
        })

        // Rotation Section
        local labelRotation = GUI.Draw({
            text = "Camera rotation:"
            collection = window
        })

        x = (windowWidth - labelRotation.getSize().width) / 2, y += labelPosition.getSize().height
        labelRotation.setRelativePosition(x, y)

        x = marginX, y += labelRotation.getSize().height + spacingY

        inputRotationX = GUI.NumberInput({
            relativePosition = {x = x, y = y}
            size = {width = oneThirdWidth, height = inputHeight}
            file = "MENU_CHOICE_BACK.TGA"
            font = "FONT_OLD_10_WHITE_HI.TGA"
            align = Align.Left
            paddingPx = 4
            collection = window
        })

        x += oneThirdWidth + spacingX

        inputRotationY = GUI.NumberInput({
            relativePosition = {x = x, y = y}
            size = {width = oneThirdWidth, height = inputHeight}
            file = "MENU_CHOICE_BACK.TGA"
            font = "FONT_OLD_10_WHITE_HI.TGA"
            align = Align.Left
            paddingPx = 4
            collection = window
        })

        x += oneThirdWidth + spacingX

        inputRotationZ = GUI.NumberInput({
            relativePosition = {x = x, y = y}
            size = {width = oneThirdWidth height = inputHeight}
            file = "MENU_CHOICE_BACK.TGA"
            font = "FONT_OLD_10_WHITE_HI.TGA"
            align = Align.Left
            paddingPx = 4
            collection = window
        })

        // Movement speed Section
        x = marginX, y += inputHeight + spacingY

        local labelMovementSpeed = GUI.Draw({
            relativePosition = {x = x, y = y}
            text = "Camera movement speed:"
            collection = window
        })

        local labelMovementSpeedSize = labelMovementSpeed.getSize().width + anx(10)
        x += labelMovementSpeedSize, y += inputSpacing

        inputMovementSpeed = GUI.NumberInput({
            relativePosition = {x = x, y = y}
            size = {width = windowWidth - labelMovementSpeedSize - marginX * 2, height = inputHeight}
            file = "MENU_CHOICE_BACK.TGA"
            font = "FONT_OLD_10_WHITE_HI.TGA"
            align = Align.Left
            paddingPx = 4
            collection = window
        })

        // Rotation speed Section
        x = marginX, y += labelMovementSpeed.getSize().height - inputSpacing

        local labelRotationSpeed = GUI.Draw({
            relativePosition = {x = x, y = y}
            text = "Camera rotation speed:"
            collection = window
        })

        local labelRotationSpeedSize = labelRotationSpeed.getSize().width + anx(10)
        x += labelRotationSpeedSize, y += inputSpacing

        inputRotationSpeed = GUI.NumberInput({
            relativePosition = {x = x, y = y}
            size = {width = windowWidth - labelRotationSpeedSize - marginX * 2, height = inputHeight}
            file = "MENU_CHOICE_BACK.TGA"
            font = "FONT_OLD_10_WHITE_HI.TGA"
            align = Align.Left
            paddingPx = 4
            collection = window
        })

        // Apply Section
        x = marginX, y += labelRotationSpeed.getSize().height + spacingY

        buttonApply = GUI.Button({
            relativePosition = {x = x, y = y}
            size = {width = windowWidth - marginX * 2, height = any(20)}
            file = "INV_SLOT_EQUIPPED.TGA"
            draw = {text = "Apply changes"}
            collection = window
        })

        // Window Section
        y += any(35)

        window.setSize(windowWidth, y)
    }

    function render()
    {
        if (!getVisible())
            return

        local position = Camera.getPosition()
        local rotation = Camera.getRotation()

        inputPositionX.setText(position.x.tostring())
        inputPositionY.setText(position.y.tostring())
        inputPositionZ.setText(position.z.tostring())

        inputRotationX.setText(rotation.x.tostring())
        inputRotationY.setText(rotation.y.tostring())
        inputRotationZ.setText(rotation.z.tostring())

        inputMovementSpeed.setText(getFreeCamMovementSpeed().tostring())
        inputRotationSpeed.setText(getFreeCamRotationSpeed().tostring())
    }

    function applyChanges()
    {
        Camera.setPosition(inputPositionX.getText().tofloat(), inputPositionY.getText().tofloat(), inputPositionZ.getText().tofloat())
        Camera.setRotation(inputRotationX.getText().tofloat(), inputRotationY.getText().tofloat(), inputRotationZ.getText().tofloat())

        setFreeCamMovementSpeed(inputMovementSpeed.getText().tofloat())
        setFreeCamRotationSpeed(inputRotationSpeed.getText().tofloat())
    }

    function getVisible()
    {
        return window.getVisible()
    }

    function setVisible(visible)
    {
        window.setVisible(visible)
    }
}


local CameraPathEditorView =
{
    window = null

    inputPathName = null

    listPaths = null

    buttonAddPath = null
    buttonRemovePath = null
    buttonUpdatePath = null

    listPoints = null

    checkboxLoopPath = null

    inputBeginPoint = null
    inputEndPoint = null

    buttonGenerate = null
    buttonStart = null
    buttonStop = null
    buttonPlay = null
    buttonPause = null

    inputPointPositionX = null
    inputPointPositionY = null
    inputPointPositionZ = null

    inputPointRotationX = null
    inputPointRotationY = null
    inputPointRotationZ = null

    inputPointPositionLerpSpeed = null
    inputPointRotationLerpSpeed = null

    checkBoxSharedLerpSpeed = null

    inputPointWaitTime = null

    buttonAddPoint = null
    buttonUpdatePoint = null
    buttonRemovePoint = null

    // logic vars

    selectedPointId = -1
    selectedCameraPathId = -1
    cameraPaths = null

    function init()
    {
        cameraPaths = []

        local windowWidth = anx(450)
        local marginX = anx(20), spacingX = anx(10), spacingY = any(5)
        local halfWidth = windowWidth / 2 - marginX, oneThirdWidth = windowWidth / 3 - marginX, fullWidth = windowWidth - marginX * 2
        local inputHeight = any(12), buttonHeight = any(20)
        local x = 0, y = 0

        window = GUI.Window({
            position = {x = x, y = y}
            file = "MENU_INGAME.TGA"
            disabled = true
        })

        // Title Section
        local labelTitle = GUI.Draw({
            text = "CameraPath editor"
            font = "FONT_OLD_20_WHITE.TGA"
            collection = window
        })

        x = (windowWidth - labelTitle.getSize().width) / 2, y += spacingY
        labelTitle.setPosition(x, y)

        // Path name Section
        x = marginX, y += labelTitle.getSize().height + spacingY

        inputPathName = GUI.Input({
            position = {x = x, y = y}
            size = {width = windowWidth - marginX * 2, height = inputHeight}
            file = "MENU_CHOICE_BACK.TGA"
            font = "FONT_OLD_10_WHITE_HI.TGA"
            align = Align.Left
            placeholder = "Path name"
            collection = window
        })

        // Paths list Section
        y += inputHeight + spacingY

        listPaths = GUI.List({
            position = {x = x, y = y}
            size = {width = fullWidth, height = any(10) * 10}
            file = "MENU_INGAME.TGA"
            marginPx = [0, 0, 0, 12]
            align = Align.Left
            scrollbar = {
                range = {
                    file = "MENU_INGAME.TGA"
                    indicator = {file = "BAR_MISC.TGA"}
                }
                increaseButton = {file = "O.TGA"}
                decreaseButton = {file = "U.TGA"}
            }
            collection = window
        })

        // Path buttons Section

        x = marginX, y += listPaths.getSize().height + spacingY

        buttonAddPath = GUI.Button({
            position = {x = x, y = y}
            size = {width = oneThirdWidth, height = buttonHeight}
            file = "INV_SLOT_EQUIPPED.TGA"
            draw = {text = "Add path"}
            collection = window
        })

        x += oneThirdWidth + spacingX

        buttonRemovePath = GUI.Button({
            position = {x = x, y = y}
            size = {width = oneThirdWidth, height = buttonHeight}
            file = "INV_SLOT_EQUIPPED.TGA"
            draw = {text = "Remove path"}
            collection = window
        })

        x += oneThirdWidth + spacingX

        buttonUpdatePath = GUI.Button({
            position = {x = x, y = y}
            size = {width = oneThirdWidth, height = buttonHeight}
            file = "INV_SLOT_EQUIPPED.TGA"
            draw = {text = "Update path"}
            collection = window
        })

        // Points list Section

        x = marginX, y += buttonUpdatePath.getSize().height + spacingY

        listPoints = GUI.List({
            position = {x = x, y = y}
            size = {width = fullWidth, height = any(10) * 10}
            file = "MENU_INGAME.TGA"
            align = Align.Left
            marginPx = [0, 0, 0, 12]
            scrollbar = {
                range = {
                    file = "MENU_INGAME.TGA"
                    indicator = {file = "BAR_MISC.TGA"}
                }
                increaseButton = {file = "O.TGA"}
                decreaseButton = {file = "U.TGA"}
            }
            collection = window
        })

        // General purpose path buttons Section

        x = marginX, y += listPoints.getSize().height + spacingY

        buttonAddPoint = GUI.Button({
            position = {x = x, y = y}
            size = {width = oneThirdWidth, height = buttonHeight}
            file = "INV_SLOT_EQUIPPED.TGA"
            draw = {text = "Add point"}
            collection = window
        })

        x += oneThirdWidth + spacingX

        buttonRemovePoint = GUI.Button({
            position = {x = x, y = y}
            size = {width = oneThirdWidth, height = buttonHeight}
            file = "INV_SLOT_EQUIPPED.TGA"
            draw = {text = "Remove point"}
            collection = window
        })

        x += oneThirdWidth + spacingX

        buttonUpdatePoint = GUI.Button({
            position = {x = x, y = y}
            size = {width = oneThirdWidth height = buttonHeight}
            file = "INV_SLOT_EQUIPPED.TGA"
            draw = {text  = "Update point"}
            collection = window
        })

        // Point properties Section

        local labelSelectedPoint = GUI.Draw({
            text = "Selected Point"
            font = "FONT_OLD_20_WHITE.TGA"
            collection = window
        })

        x = (windowWidth - labelSelectedPoint.getSize().width) / 2, y += buttonUpdatePoint.getSize().height + spacingY
        labelSelectedPoint.setPosition(x, y)

        // Point position Section

        local labelPointPosition = GUI.Draw({
            text = "position:"
            collection = window
        })

        x = (windowWidth - labelPointPosition.getSize().width) / 2, y += labelSelectedPoint.getSize().height
        labelPointPosition.setPosition(x, y)

        x = marginX, y += labelPointPosition.getSize().height + spacingY

        inputPointPositionX = GUI.NumberInput({
            position = {x = x, y = y}
            size = {width = oneThirdWidth height = inputHeight}
            file = "MENU_CHOICE_BACK.TGA"
            font = "FONT_OLD_10_WHITE_HI.TGA"
            align = Align.Left
            paddingPx = 4
            collection = window
        })

        x += oneThirdWidth + spacingX

        inputPointPositionY = GUI.NumberInput({
            position = {x = x, y = y}
            size = {width = oneThirdWidth height = inputHeight}
            file = "MENU_CHOICE_BACK.TGA"
            font = "FONT_OLD_10_WHITE_HI.TGA"
            align = Align.Left
            paddingPx = 4
            collection = window
        })

        x += oneThirdWidth + spacingX

        inputPointPositionZ = GUI.NumberInput({
            position = {x = x, y = y}
            size = {width = oneThirdWidth, height = inputHeight}
            file = "MENU_CHOICE_BACK.TGA"
            font = "FONT_OLD_10_WHITE_HI.TGA"
            align = Align.Left
            paddingPx = 4
            collection = window
        })

        // Point rotation Section

        local labelPointRotation = GUI.Draw({
            text = "rotation:"
            collection = window
        })

        x = (windowWidth - labelPointRotation.getSize().width) / 2, y += labelPointPosition.getSize().height
        labelPointRotation.setPosition(x, y)

        x = marginX, y += labelPointRotation.getSize().height + spacingY

        inputPointRotationX = GUI.NumberInput({
            position = {x = x, y = y}
            size = {width = oneThirdWidth, height = inputHeight}
            file = "MENU_CHOICE_BACK.TGA"
            font = "FONT_OLD_10_WHITE_HI.TGA"
            align = Align.Left
            paddingPx = 4
            collection = window
        })

        x += oneThirdWidth + spacingX

        inputPointRotationY = GUI.NumberInput({
            position = {x = x, y = y}
            size = {width = oneThirdWidth, height = inputHeight}
            file = "MENU_CHOICE_BACK.TGA"
            font = "FONT_OLD_10_WHITE_HI.TGA"
            align = Align.Left
            paddingPx = 4
            collection = window
        })

        x += oneThirdWidth + spacingX

        inputPointRotationZ = GUI.NumberInput({
            position = {x = x, y = y}
            size = {width = oneThirdWidth, height = inputHeight}
            file = "MENU_CHOICE_BACK.TGA"
            font = "FONT_OLD_10_WHITE_HI.TGA"
            align = Align.Left
            paddingPx = 4
            collection = window
        })

        // Point position lerp speed Section

        x = marginX, y += inputHeight + spacingY

        local labelPointPositionLerpSpeed = GUI.Draw({
            position = {x = x, y = y}
            text = "positionLerpSpeed:"
            collection = window
        })

        local labelPointPositionLerpSpeedSize = labelPointPositionLerpSpeed.getSize().width + anx(10)
        x += labelPointPositionLerpSpeedSize, y += spacingY

        inputPointPositionLerpSpeed = GUI.NumberInput({
            position = {x = x, y =  y}
            size = {width = windowWidth - labelPointPositionLerpSpeedSize - marginX * 2, height = inputHeight}
            file = "MENU_CHOICE_BACK.TGA"
            font = "FONT_OLD_10_WHITE_HI.TGA",
            text = CameraPoint.positionLerpSpeed.tostring()
            align = Align.Left
            paddingPx = 4
            collection = window
        })

        // Point rotation lerp speed Section

        x = marginX, y += labelPointPositionLerpSpeed.getSize().height - spacingY

        local labelPointRotationLerpSpeed = GUI.Draw({
            position = {x = x, y = y}
            text = "rotationLerpSpeed:"
            collection = window
        })

        local labelPointRotationLerpSpeedSize = labelPointRotationLerpSpeed.getSize().width + anx(10)
        x += labelPointRotationLerpSpeedSize, y += spacingY

        inputPointRotationLerpSpeed = GUI.NumberInput({
            position = {x = x, y = y}
            size = {width = windowWidth - labelPointRotationLerpSpeedSize - marginX * 2, height = inputHeight}
            file = "MENU_CHOICE_BACK.TGA"
            font = "FONT_OLD_10_WHITE_HI.TGA"
            text = CameraPoint.rotationLerpSpeed.tostring()
            align = Align.Left,
            paddingPx = 4
            collection = window
        })

        // Shared lerp speed Section

        x = marginX, y += labelPointRotationLerpSpeed.getSize().height - any(5) + any(3)

        local labelPointSharedLerpSpeed = GUI.Draw({
            position = {x = x, y = y}
            text = "shared lerp speed:"
            collection = window
        })

        x += labelPointSharedLerpSpeed.getSize().width + anx(10)

        checkBoxSharedLerpSpeed = GUI.CheckBox({
            position = {x = x, y = y}
            sizePx = {width = 15, height = 15}
            file = "INV_SLOT_EQUIPPED_FOCUS.TGA"
            draw = {text = "X"}
            checked = true
            collection = window
        })

        // Point wait time Section

        x += checkBoxSharedLerpSpeed.getSize().width + anx(5), y -= any(3)

        local labelWaitTime = GUI.Draw({
            position = {x = x, y = y}
            text = "waitTime:"
            collection = window
        })

        local labelWaitTimeSize = labelWaitTime.getSize().width + anx(10)
        x += labelWaitTimeSize, y += any(5)

        inputPointWaitTime = GUI.NumberInput({
            position = {x = x, y = y}
            size = {width = windowWidth - x - marginX, height = inputHeight}
            file = "MENU_CHOICE_BACK.TGA"
            font = "FONT_OLD_10_WHITE_HI.TGA"
            text = CameraPoint.waitTime.tostring()
            align = Align.Left
            paddingPx = 4
            collection = window
        })

        // Playback settings Section

        local labelPlaybackSettings = GUI.Draw({
            text = "Playback settings"
            font = "FONT_OLD_20_WHITE.TGA"
            collection = window
        })

        x = (windowWidth - labelPlaybackSettings.getSize().width) / 2, y += labelPointSharedLerpSpeed.getSize().height + spacingY
        labelPlaybackSettings.setPosition(x, y)

        // Loop path Section

        x = marginX, y += labelPlaybackSettings.getSize().height + spacingY

        local labelLoopPath = GUI.Draw({
            position = {x = x, y = y}
            text = "loop path:"
            collection = window
        })

        x += labelLoopPath.getSize().width + anx(10)

        checkboxLoopPath = GUI.CheckBox({
            position = {x = x, y = y}
            sizePx = {width = 15, height = 15}
            file = "INV_SLOT_EQUIPPED_FOCUS.TGA"
            draw = {text = "X"}
            collection = window
        })

        // from, to Section

        x += checkboxLoopPath.getSize().width + anx(10)

        local labelFromTo = GUI.Draw({
            position = {x = x, y = y}
            text = "from, to:"
            collection = window
        })

        x += labelFromTo.getSize().width + anx(5), y += spacingY
        local inputWidth = (windowWidth - x - marginX) / 2

        inputBeginPoint = GUI.NumberInput({
            position = {x = x, y = y}
            size = {width = inputWidth height =inputHeight}
            file = "MENU_CHOICE_BACK.TGA"
            font = "FONT_OLD_10_WHITE_HI.TGA"
            align = Align.Left
            paddingPx = 4
            collection = window
        })

        x += inputWidth + spacingX

        inputEndPoint = GUI.NumberInput({
            position = {x = x, y = y}
            size = {width = inputWidth - spacingX, height = inputHeight}
            file = "MENU_CHOICE_BACK.TGA"
            font = "FONT_OLD_10_WHITE_HI.TGA"
            align = Align.Left
            paddingPx = 4
            collection = window
        })

        // Point buttons Section

        // 1st row

        x = marginX, y += labelLoopPath.getSize().height + spacingY

        buttonStart = GUI.Button({
            position = {x = x, y = y}
            size = {width = halfWidth, height = buttonHeight}
            file =  "INV_SLOT_EQUIPPED.TGA"
            draw = {text = "Start"}
            collection = window
        })

        x += halfWidth + spacingX

        buttonStop = GUI.Button({
            position = {x = x, y =  y}
            size = {width = halfWidth - spacingX, height = buttonHeight}
            file = "INV_SLOT_EQUIPPED.TGA"
            draw = {text = "Stop"}
            collection = window
        })

        // 2nd row

        x = marginX, y += buttonStop.getSize().height + spacingY

        buttonPlay = GUI.Button({
            position = {x = x, y = y}
            size = {width = halfWidth, height = buttonHeight}
            file = "INV_SLOT_EQUIPPED.TGA"
            draw = {text = "Play"}
            collection = window
        })

        x += halfWidth + spacingX

        buttonPause = GUI.Button({
            position = {x = x, y = y}
            size = {width = halfWidth - spacingX, height = buttonHeight}
            file = "INV_SLOT_EQUIPPED.TGA"
            draw = {text = "Pause"}
            collection = window
        })

        // 3rd row

        x = marginX, y += buttonPause.getSize().height + spacingY

        buttonGenerate = GUI.Button({
            position = {x = x, y = y}
            size = {width = fullWidth, height = buttonHeight}
            file = "INV_SLOT_EQUIPPED.TGA"
            draw = {text = "Generate"}
            collection = window
        })

        // Window Section

        y += any(35)

        window.setSize(windowWidth, y)
    }

    function getVisible()
    {
        return window.getVisible()
    }

    function setVisible(visible)
    {
        window.setVisible(visible)
    }

    function start()
    {
        if (selectedCameraPathId == -1)
            return

        cameraPaths[selectedCameraPathId].start()
    }

    function stop()
    {
        if (selectedCameraPathId == -1)
            return

        cameraPaths[selectedCameraPathId].stop()
    }

    function play()
    {
        if (selectedCameraPathId == -1)
            return

        cameraPaths[selectedCameraPathId].play()
    }

    function pause()
    {
        if (selectedCameraPathId == -1)
            return

        cameraPaths[selectedCameraPathId].pause()
    }

    function _generateCreatePoint(pathName, point)
    {
        local text = ""

        text += pathName + ".createPoint({"
        text += "position = [" + point.position.x + ", " + point.position.y + ", " + point.position.z + "], "
        text += "rotation = [" + point.rotation.x + ", " + point.rotation.y + ", " + point.rotation.z + "], "

        if (point.positionLerpSpeed == point.rotationLerpSpeed)
            text += "lerpSpeed = " + point.positionLerpSpeed
        else
        {
            text += "positionLerpSpeed = " + point.positionLerpSpeed + ", "
            text += "rotationLerpSpeed = " + point.rotationLerpSpeed
        }

        if (point.waitTime != 0)
            text += ", waitTime = " + point.waitTime

        text += "})\n"

        return text
    }

    function _generateLoopPoint(pathName)
    {
        local text = ""

        text += pathName + ".addPoint("
        text += pathName + ".points[0]"
        text +=  ")\n"

        return text
    }

    function generate()
    {
        if (selectedCameraPathId == -1)
            return

        local selectedCameraPath = cameraPaths[selectedCameraPathId]

        if (selectedCameraPath.points.len() < 2)
            return

        local pathName = inputPathName.getText()

        if (pathName == "")
            pathName = "path"

        local text = "local " + pathName + " = CameraPath()\n\n"

        if (selectedCameraPath.isLooping)
        {
            text += pathName + ".setLooping(true)\n\n"
        }

        foreach (point in selectedCameraPath.points)
            text += _generateCreatePoint(pathName, point)

        setClipboardText(text)
    }

    function toggleLoopPath()
    {
        if (selectedCameraPathId == -1)
            return

        cameraPaths[selectedCameraPathId].setLooping(checkboxLoopPath.getChecked())
    }

    function addExistingPath(path)
    {
        listPaths.addRow({text = path.designerName})
        cameraPaths.push(path)
    }

    function addPath()
    {
        local pathName = inputPathName.getText()

        if (pathName == "")
            return

        CameraPath(pathName) // dummy creation of an object (no worries, it won't be deleted, because we will cache the reference to it in addExistingPath method)
    }

    function removePath()
    {
        if (selectedCameraPathId == -1)
            return

        listPaths.removeRow(selectedCameraPathId)
        cameraPaths.remove(selectedCameraPathId)

        selectedCameraPathId = -1
    }

    function updatePath()
    {
        if (selectedCameraPathId == -1)
            return

        listPaths.rows[selectedCameraPathId].cells[0].setText(inputPathName.getText())
    }

    function toggleSelectedPath(cell)
    {
        if (selectedCameraPathId != -1)
            listPaths.rows[selectedCameraPathId].setDrawColor({r = 255, g = 255, b = 255})

        selectedCameraPathId = cell.id
        cell.setDrawColor({r = 255, g = 0, b = 0})

        local cameraPath = cameraPaths[selectedCameraPathId]
        local pointsCount = cameraPath.points.len()
        local rowsCount = listPoints.rows.len()

        for (local id = 0; id != pointsCount; ++id)
        {
            local text = "point #" + (id + 1)

            if (id >= rowsCount)
            {
                listPoints.addRow({text = text})
                ++rowsCount
            }
            else
                listPoints.rows[id].cells[0].setText(text)
        }

        for (local id = rowsCount - 1; id >= pointsCount; --id)
            listPoints.removeRow(id)
    }

    function addPoint()
    {
        if (selectedCameraPathId == -1)
            return

        local pointId = listPoints.rows.len()

        local position = Camera.getPosition()
        local rotation = Camera.getRotation()

        local positionLerpSpeed = inputPointPositionLerpSpeed.getText()

        if (positionLerpSpeed == "")
            positionLerpSpeed = 0

        local rotationLerpSpeed = inputPointRotationLerpSpeed.getText()

        if (rotationLerpSpeed == "")
            rotationLerpSpeed = 0

        local waitTime = inputPointWaitTime.getText()

        if (waitTime == "")
            waitTime = 0

        listPoints.insertRow(pointId, {text = "point #" + (pointId + 1)})

        cameraPaths[selectedCameraPathId].createPoint({
            position = [position.x, position.y, position.z],
            rotation = [rotation.x, rotation.y, rotation.z],
            positionLerpSpeed = positionLerpSpeed.tofloat(),
            rotationLerpSpeed = rotationLerpSpeed.tofloat(),
            waitTime = waitTime.tointeger()
        })
    }

    function removePoint()
    {
        if (selectedCameraPathId == -1)
            return

        if (selectedPointId == -1)
            return

        listPoints.removeRow(selectedPointId)

        for (local idx = selectedPointId, end = listPoints.rows.len(); idx != end; ++idx)
            listPoints.rows[idx].cells[0].setText("point #" + (idx + 1))

        cameraPaths[selectedCameraPathId].points.remove(selectedPointId)
        selectedPointId = -1

    }

    function updatePoint()
    {
        if (selectedCameraPathId == -1)
            return

        if (selectedPointId == -1)
            return

        local point = cameraPaths[selectedCameraPathId].points[selectedPointId]

        local positionX = inputPointPositionX.getText()

        if (positionX != "")
            point.position.x = positionX.tofloat()

        local positionY = inputPointPositionY.getText()

        if (positionY != "")
            point.position.y = positionY.tofloat()

        local positionZ = inputPointPositionZ.getText()

        if (positionZ != "")
            point.position.z = positionZ.tofloat()

        local rotationX = inputPointRotationX.getText()

        if (rotationX != "")
            point.rotation.x = rotationX.tofloat()

        local rotationY = inputPointRotationY.getText()

        if (rotationY != "")
            point.rotation.y = rotationY.tofloat()

        local rotationZ = inputPointRotationZ.getText()

        if (rotationZ != "")
            point.rotation.z = rotationZ.tofloat()

        local positionLerpSpeed = inputPointPositionLerpSpeed.getText()

        if (positionLerpSpeed != "")
            point.setPositionLerpSpeed(positionLerpSpeed.tofloat())

        local rotationLerpSpeed = inputPointRotationLerpSpeed.getText()

        if (rotationLerpSpeed != "")
            point.setRotationLerpSpeed(rotationLerpSpeed.tofloat())

        local waitTime = inputPointWaitTime.getText()

        if (waitTime != "")
            point.setWaitTime(waitTime.tointeger())
    }

    function toggleSelectedPoint(cell)
    {
        if (selectedPointId != -1)
            listPoints.rows[selectedPointId].setDrawColor({r = 255, g = 255, b = 255})

        selectedPointId = cell.id
        cell.setDrawColor({r = 255, g = 0, b = 0})

        local point = cameraPaths[selectedCameraPathId].points[selectedPointId]

        inputPointPositionX.setText(point.position.x.tostring())
        inputPointPositionY.setText(point.position.y.tostring())
        inputPointPositionZ.setText(point.position.z.tostring())

        inputPointRotationX.setText(point.rotation.x.tostring())
        inputPointRotationY.setText(point.rotation.y.tostring())
        inputPointRotationZ.setText(point.rotation.z.tostring())

        inputPointPositionLerpSpeed.setText(point.positionLerpSpeed.tostring())
        inputPointRotationLerpSpeed.setText(point.rotationLerpSpeed.tostring())

        inputPointWaitTime.setText(point.waitTime.tostring())

        Camera.setPosition(point.position.x, point.position.y, point.position.z)
        Camera.setRotation(point.rotation.x, point.rotation.y, point.rotation.z)

        FreeCamView.render()
    }
}

/*
    Events
*/

CameraPathEditorView.init()
FreeCamView.init()

addEventHandler("onRender", function()
{
    if (isFreeCamPaused())
        return

    FreeCamView.render()
})

addEventHandler("onKeyDown", function(key)
{
    switch (key)
    {
        case KEY_INSERT:
            if (!CameraPathEditorView.getVisible())
                return

            local toggle = !isFreeCamPaused()

            pauseFreeCam(toggle)

            CameraPathEditorView.listPaths.setDisabled(!toggle)
            CameraPathEditorView.listPoints.setDisabled(!toggle)

            if (toggle)
            {
                local cursorSize = getCursorSize()
                setCursorPosition(4096 - cursorSize.width, 4096 - cursorSize.height)
            }

            setCursorVisible(toggle)
            break

        case KEY_END:
            local toggle = !CameraPathEditorView.getVisible()

            if (!toggle && isCursorVisible())
                setCursorVisible(false)
            else if (toggle && isFreeCamPaused())
                setCursorVisible(true)

            CameraPathEditorView.setVisible(toggle)
            FreeCamView.setVisible(toggle)
            break

        case KEY_HOME:
            local toggle = !isFreeCamEnabled()

            if (!toggle && isCursorVisible())
                setCursorVisible(false)

            enableFreeCam(toggle)

            CameraPathEditorView.setVisible(toggle)
            FreeCamView.setVisible(toggle)
            break
    }
})

addEventHandler("CameraPath.onCreate", function(self)
{
    CameraPathEditorView.addExistingPath(self)
})

addEventHandler("CameraPath.onStop", function(self)
{
    if (CameraPathEditorView.selectedCameraPathId == -1)
        return

    local cameraPath = CameraPathEditorView.cameraPaths[CameraPathEditorView.selectedCameraPathId]

    if (self != cameraPath)
        return

    Camera.movementEnabled = false
	Camera.modeChangeEnabled = false
})

CameraPathEditorView.checkboxLoopPath.bind(EventType.Click, function(self)
{
    CameraPathEditorView.toggleLoopPath()
})

CameraPathEditorView.buttonStart.bind(EventType.Click, function(self)
{
    CameraPathEditorView.start()
})

CameraPathEditorView.buttonStop.bind(EventType.Click, function(self)
{
    CameraPathEditorView.stop()
})

CameraPathEditorView.buttonPlay.bind(EventType.Click, function(self)
{
    CameraPathEditorView.play()
})

CameraPathEditorView.buttonPause.bind(EventType.Click, function(self)
{
    CameraPathEditorView.pause()
})

CameraPathEditorView.buttonGenerate.bind(EventType.Click, function(self)
{
    CameraPathEditorView.generate()
})

CameraPathEditorView.buttonAddPath.bind(EventType.Click, function(self)
{
    CameraPathEditorView.addPath()
})

CameraPathEditorView.buttonRemovePath.bind(EventType.Click, function(self)
{
    CameraPathEditorView.removePath()
})

CameraPathEditorView.buttonUpdatePath.bind(EventType.Click, function(self)
{
    CameraPathEditorView.updatePath()
})

CameraPathEditorView.buttonAddPoint.bind(EventType.Click, function(self)
{
    CameraPathEditorView.addPoint()
})

CameraPathEditorView.buttonUpdatePoint.bind(EventType.Click, function(self)
{
    CameraPathEditorView.updatePoint()
})

CameraPathEditorView.buttonRemovePoint.bind(EventType.Click, function(self)
{
    CameraPathEditorView.removePoint()
})

FreeCamView.buttonApply.bind(EventType.Click, function(self)
{
    FreeCamView.applyChanges()
})

addEventHandler("GUI.onClick", function(self)
{
	if (!(self instanceof GUI.ListVisibleRow))
		return

    switch (self.parent)
    {
        case CameraPathEditorView.listPaths:
            CameraPathEditorView.toggleSelectedPath(self.getDataRow())
            break

        case CameraPathEditorView.listPoints:
            CameraPathEditorView.toggleSelectedPoint(self.getDataRow())
            break
    }
})

CameraPathEditorView.inputPointPositionLerpSpeed.bind(EventType.KeyInput, function(self, key, letter)
{
    if (CameraPathEditorView.checkBoxSharedLerpSpeed.getChecked())
        CameraPathEditorView.inputPointRotationLerpSpeed.setText(CameraPathEditorView.inputPointPositionLerpSpeed.getText())
})

CameraPathEditorView.inputPointRotationLerpSpeed.bind(EventType.KeyInput, function(self, key, letter)
{
    if (CameraPathEditorView.checkBoxSharedLerpSpeed.getChecked())
        CameraPathEditorView.inputPointPositionLerpSpeed.setText(CameraPathEditorView.inputPointRotationLerpSpeed.getText())
})
