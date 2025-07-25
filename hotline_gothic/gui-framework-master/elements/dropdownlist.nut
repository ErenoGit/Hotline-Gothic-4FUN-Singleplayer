local ref =
{
	activeDropdownList = null
}

class GUI.DropDownList extends GUI.Button
{
#public:
	list = null

#private:
	_maxHeightPx = 0
	_selectedIndex = -1
	_placeHolder = ""

	constructor(arg = null)
	{
		list = GUI.List("list" in arg ? arg.list : null)
		list.parent = this

		base.constructor(arg)

		list.setRowHeightPx(getSizePx().height)

		if ("maxHeightPx" in arg)
			_maxHeightPx = arg.maxHeightPx
		else if ("maxHeight" in arg)
			_maxHeightPx = nay(listMaxHeight)

		if ("rows" in arg)
		{
			foreach (row in arg.rows)
				addRow(row)
		}

		if ("selectedIndex" in arg)
			setSelectedIndex(arg.selectedIndex)

		_placeHolder = ("placeHolder" in arg) ? (arg.placeHolder) : (draw != null ? draw.getText() : _placeHolder)
		this.bind(EventType.Click, onClick)
		updateVisibleElements()
	}

	function getPlaceHolder()
	{
		return _placeHolder
	}

	function setPlaceHolder(placeHolder)
	{
		_placeHolder = placeHolder

		if (_selectedIndex == -1)
			setText(placeHolder)
	}

	function setPositionPx(x, y)
	{
		base.setPositionPx(x, y)
		updateListPosition()
	}

	function setSizePx(width, height)
	{
		base.setSizePx(width, height)
		updateVisibleElements()
	}

	function setMarginPx(top, right, bottom, left)
	{
		list._marginPx =
		{
			top = top,
			right = right
			bottom = bottom,
			left = left,
		}

		updateVisibleElements()
	}

	function setRowHeightPx(rowHeight)
	{
		list._rowHeightPx = rowHeight
		updateVisibleElements()
	}

	function setRowHeight(rowHeight)
	{
		setRowHeightPx(nay(rowHeight))
	}

	function setRowSpacingPx(rowSpacing)
	{
		list._rowSpacingPx = rowSpacing
		updateVisibleElements()
	}

	function setRowSpacing(rowSpacing)
	{
		setRowSpacingPx(nay(rowSpacing))
	}

	function getMaxHeightPx()
	{
		return _maxHeightPx
	}

	function setMaxHeightPx(maxHeight)
	{
		_maxHeightPx = maxHeight
		updateVisibleElements()
	}

	function getMaxHeight()
	{
		return any(_maxHeightPx)
	}

	function setMaxHeight(maxHeight)
	{
		setMaxHeightPx(nay(maxHeight))
	}

	function setVisible(toggle)
	{
		if (!toggle && list.getVisible())
			toggleOpen()

		base.setVisible(toggle)
	}

	function insertRow(rowId, arg)
	{
		local row = list.insertRow(rowId, arg)
		if (list.rows.len() <= list.visibleRows.len())
			updateListSize()

		if (list.rows.len() == 1)
			setSelectedIndex(0)

		return row
	}

	function addRow(arg)
	{
		return insertRow(list.rows.len(), arg)
	}

	function removeRow(rowId)
	{
		if (list.rows.len() == 1 || rowId == _selectedIndex)
			setSelectedIndex(-1)

		list.removeRow(rowId)
		if (list.rows.len() < list.visibleRows.len())
			updateListSize()
	}

	function clear()
	{
		setSelectedIndex(-1)

		list.clear()
		updateListSize()
	}

	function getSelectedIndex()
	{
		return _selectedIndex
	}

	function setSelectedIndex(selectedIndex)
	{
		_selectedIndex = selectedIndex
		setText(_selectedIndex != -1 ? getSelectedRow().getText() : _placeHolder)
	}

	function getSelectedRow()
	{
		if (_selectedIndex == -1)
			return null

		return list.rows[_selectedIndex]
	}

	function toggleOpen()
	{
		local visible = !list.getVisible()
		list.setVisible(visible)
		ref.activeDropdownList = visible ? this.weakref() : null

		if (visible && list.scrollbar.range.getMaximum() > 0)
			GUI.ScrollBar.setActiveScrollbar(Orientation.Vertical, list.scrollbar)
	}

	function updateListPosition()
	{
		local positionPx = getPositionPx()
		local listHeightPx = list.getSizePx().height
		local maxHeight = getResolution().y

		local newBottomPos = positionPx.y + getSizePx().height
		local newY = ((newBottomPos + listHeightPx) <= maxHeight) ? newBottomPos : (positionPx.y - listHeightPx)

		list.setPositionPx(positionPx.x, newY)
	}

	function updateListSize()
	{
		local sizePx = getSizePx()
		local margin = list.getMarginPx()

		if (list._visibleRowsCount != 0)
			GUI.Texture.setSizePx.call(list, sizePx.width, ((list.getRowHeightPx() + list.getRowSpacingPx()) * list._visibleRowsCount) + (margin.top + margin.bottom))
		else
			GUI.Texture.setSizePx.call(list, sizePx.width, 0)

		updateListPosition()
	}

	function updateVisibleElements()
	{
		local oldVisibleRowsLen = list.visibleRows.len()
		local sizePx = getSizePx()
		local margin = list.getMarginPx()
		local rowHeight = list.getRowHeightPx()
		local rowSpacing = list.getRowSpacingPx()
		local rowSize = rowHeight + rowSpacing
		local rowsLen = list.rows.len()
		local visibleRowsLen = (rowHeight > 0) ? ((_maxHeightPx - margin.top - margin.bottom + rowSpacing) / rowSize) : 0

		list._visibleRowsCount = visibleRowsLen <= rowsLen ? visibleRowsLen : rowsLen

		// Insert visibleRows loop:
		local alignment = list.getAlignment()
		local isOpen = list.getVisible()
		for (local i = oldVisibleRowsLen; i < visibleRowsLen; ++i)
		{
			local visibleRow = GUI.ListVisibleRow(i, list)
			visibleRow.setAlignment(alignment)
			visibleRow.setVisible(isOpen)
			visibleRow.bind(EventType.Click, row_onClick)

			list.visibleRows.push(visibleRow)
		}

		//  Remove visibleRows loop:
		for (local i = oldVisibleRowsLen - 1; i >= visibleRowsLen; --i)
			list.visibleRows.remove(i)

		//  Update scrollbar:
		local positionPx = getPositionPx()
		local newPosY = positionPx.y + margin.top + sizePx.height

		local scrollbar = list.scrollbar
		local scrollbarWidth = scrollbar.getSizePx().width
		scrollbar.setPositionPx((positionPx.x + sizePx.width - scrollbarWidth), newPosY)
		scrollbar.setSizePx(scrollbarWidth, (rowSize * visibleRowsLen) + margin.top + margin.bottom)

		//  Update visible rows:
		local newPosX = positionPx.x + margin.left
		local rowWidth = sizePx.width - margin.left - margin.right
		foreach (visibleRow in list.visibleRows)
		{
			visibleRow.setPositionPx(newPosX, newPosY)
			visibleRow.setSizePx(rowWidth, rowHeight)
			newPosY += rowSize
		}

		updateListSize()

		//  Update data and scrollbar values:
		local newMax = list.getMaxScrollbarValue()
		local oldMax = scrollbar.range.getMaximum()
		if (newMax != oldMax)
		{
			scrollbar.range.setMaximum(newMax)

			if (oldMax > newMax)
				list.refresh()

			local scrollVisible = isOpen && newMax != 0
			if (scrollVisible != scrollbar.getVisible())
				scrollbar.setVisible(scrollVisible)
		}
		else
			list.refresh()
	}

	static function onClick(self)
	{
		self.toggleOpen()
	}

	static function row_onClick(self)
	{
		local dropDownList = self.parent.parent
		local dataRow = self.getDataRow()

		if (dropDownList._selectedIndex != dataRow.id)
		{
			dropDownList.setText(dataRow.getText())
			dropDownList._selectedIndex = dataRow.id

			dropDownList.call(EventType.Change)
			callEvent("GUI.onChange", this)
		}

		ref.activeDropdownList.toggleOpen()
		ref.activeDropdownList = null
	}

	static function onMouseDown(button)
	{
		if (!isCursorVisible())
			return

		if (!ref.activeDropdownList)
			return

		local elementPointedByCursor = GUI.Event.getElementPointedByCursor()
		if (elementPointedByCursor)
		{
			if (elementPointedByCursor == ref.activeDropdownList)
				return

			if (elementPointedByCursor.parent)
			{
				local parent = elementPointedByCursor.parent
				if (parent.parent)
				{
					local parent = parent.parent
					if (parent == ref.activeDropdownList)
						return

					local scrollbar = ref.activeDropdownList.list.scrollbar
					if (parent == scrollbar)
						return

					if (parent == scrollbar.increaseButton)
						return

					if (parent == scrollbar.decreaseButton)
						return
				}
			}
		}

		ref.activeDropdownList.toggleOpen()
		ref.activeDropdownList = null
	}
}

addEventHandler("onMouseDown", GUI.DropDownList.onMouseDown.bindenv(GUI.DropDownList))
