local GUIBarClasses = classes(GUI.Texture, GUI.Orientation, GUI.Alignment, GUI.Margin)
class GUI.Bar extends GUIBarClasses
{
#proteced:
	_stretching = true

	_value = 0
	_minimum = 0
	_maximum = 100

#public:
	progress = null

	constructor(arg = null)
	{
		progress = GUI.Texture("progress" in arg ? arg.progress : null)
		GUI.Margin.constructor.call(this, arg)

		_stretching = "stretching" in arg ? arg.stretching : _stretching
		_orientation = "orientation" in arg ? arg.orientation : Orientation.Horizontal
		_alignment = "align" in arg ? arg.align : Align.Left
		_minimum = "minimum" in arg ? arg.minimum : _minimum
		_maximum = "maximum" in arg ? arg.maximum : _maximum

		GUI.Texture.constructor.call(this, arg)
		setDisabled(true)
		setValue("value" in arg ? arg.value : _value)
	}

	function getValue()
	{
		return _value
	}

	function setValue(value)
	{
		if (value > _maximum)
			value = _maximum
		else if (value < _minimum)
			value = _minimum

		_value = value
		updateProgress()
	}

	function getMinimum()
	{
		return _minimum
	}

	function setMinimum(minimum)
	{
		_minimum = minimum
		setValue(_value)
	}

	function getMaximum()
	{
		return _maximum
	}

	function setMaximum(maximum)
	{
		_maximum = maximum
		setValue(_value)
	}

	function top()
	{
		GUI.Texture.top.call(this)
		progress.top()
	}

	function getStreching()
	{
		return _stretching
	}

	function setStretching(stretching)
	{
		_stretching = stretching
	}

	function setAlignment(alignment)
	{
		GUI.Alignment.setAlignment.call(this, alignment)
		updateProgress()
	}

	function setVisible(visible)
	{
		GUI.Texture.setVisible.call(this, visible)
		progress.setVisible(visible)
	}

	function setDisabled(disabled)
	{
		GUI.Texture.setDisabled.call(this, disabled)
		progress.setDisabled(disabled)
	}

	function setPositionPx(x, y)
	{
		local positionPx = getPositionPx()
		GUI.Texture.setPositionPx.call(this, x, y)

		local offsetXPx = x - positionPx.x
		local offsetYPx = y - positionPx.y

		local progressPositionPx = progress.getPositionPx()
		progress.setPositionPx(progressPositionPx.x + offsetXPx, progressPositionPx.y + offsetYPx)
	}

	function setSizePx(width, height)
	{
		GUI.Texture.setSizePx.call(this, width, height)
		updateProgress()
	}

	function setMarginPx(top, right, bottom, left)
	{
		GUI.Margin.setMarginPx.call(this, top, right, bottom, left)
		updateProgress()
	}

	function getPercentage()
	{
		return fabs(_value - _minimum) / fabs(_maximum - _minimum)
	}

	function updateProgress()
	{
		local sizePx = getSizePx()
		local positionPx = getPositionPx()
		local marginPx = getMarginPx()

		switch (_orientation)
		{
			case Orientation.Horizontal:
			{
				local percentage = getPercentage()
				local progressWidthPx = ((sizePx.width - marginPx.left - marginPx.right) * percentage).tointeger()

				switch (_alignment)
				{
					case Align.Left:
						changeProgress(0.0, 0.0, percentage, 1.0)
						progress.setPositionPx(positionPx.x + marginPx.left, positionPx.y + marginPx.top)
						break

					case Align.Right:
						changeProgress(1.0 - percentage, 0.0, percentage, 1.0)
						progress.setPositionPx(positionPx.x + sizePx.width - progressWidthPx - marginPx.right, positionPx.y + marginPx.top)
						break

					case Align.Center:
						changeProgress(0.0, 0.0, percentage, 1.0)
						progress.setPositionPx(positionPx.x + (sizePx.width - progressWidthPx) / 2, positionPx.y + marginPx.top)
						break
				}
				break
			}

			case Orientation.Vertical:
			{
				local percentage = getPercentage()
				local progressHeightPx = ((sizePx.height - marginPx.top - marginPx.bottom) * percentage).tointeger()

				switch (_alignment)
				{
					case Align.Left:
						changeProgress(0.0, 0.0, 1.0, percentage)
						progress.setPositionPx(positionPx.x + marginPx.left, positionPx.y + marginPx.top)
						break

					case Align.Right:
						changeProgress(0.0, 1.0 - percentage, 1.0, percentage)
						progress.setPositionPx(positionPx.x + marginPx.left, positionPx.y + sizePx.height - progressHeightPx - marginPx.bottom)
						break

					case Align.Center:
						changeProgress(0.0, 0.0, 1.0, percentage)
						progress.setPositionPx(positionPx.x + marginPx.right, positionPx.y + (sizePx.height - progressHeightPx) / 2)
						break
				}
				break
			}
		}
	}

	function changeProgress(uvX, uvY, uvWidth, uvHeight)
	{
		if (!_stretching)
			progress.setUV(uvX, uvY, uvWidth, uvHeight)

		local marginPx = getMarginPx()
		local sizePx = getSizePx()

		progress.setSizePx((sizePx.width - marginPx.left - marginPx.right) * uvWidth, (sizePx.height - marginPx.top - marginPx.bottom) * uvHeight)
	}
}