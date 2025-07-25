GUI <- {}

enum Orientation
{
	Horizontal,
	Vertical
}

enum Align
{
	Center,
	Left,
	Right
}

enum ScrollbarVisibilityMode
{
	Needed,
	Always,
	Never
}

const TOOLTIP_INTERVAL = 500

const RANGE_INDICATOR_SIZE = 25

const SCROLLBAR_BUTTON_SIZE = 25

const WINDOW_TOPBAR_HEIGHT = 20

const TAB_WIDTH = 100
const TAB_HEIGHT = 33

const SCROLLBAR_SIZE = 20

const DOUBLE_CLICK_TIME = 500

/////////////////////
// OOP Event types //
/////////////////////
enum EventType
{
	Render,
	ChangeResolution
	Click,
	DoubleClick,
	TakeFocus,
	LostFocus,
	KeyUp,
	KeyDown,
	KeyInput,
	MouseIn,
	MouseOut,
	MouseDrag,
	MouseMove,
	MouseUp,
	MouseDown,
	Change,
	Switch,
	InsertLetter,
	RemoveLetter,
	Max
}

////////////////////
// Global Events //
///////////////////
addEvent("GUI.onClick")
addEvent("GUI.onDoubleClick")

// base.nut
addEvent("GUI.onTakeFocus")
addEvent("GUI.onLostFocus")

addEvent("GUI.onMouseIn")
addEvent("GUI.onMouseOut")

addEvent("GUI.onMouseUp")
addEvent("GUI.onMouseDown")

// range.nut, dropdownlist.nut
addEvent("GUI.onChange")

// tabpanel.nut
addEvent("GUI.onSwitch")

// input.nut
addEvent("GUI.onKeyInput")
addEvent("GUI.onKeyDown")
addEvent("GUI.onKeyUp")

//Main init func
addEventHandler("onInit",function()
{
	//Information about the authors
	print("## Gui Engine 2.0 successfully loaded ##")
	print("- Author Tommy & Patrix")
})
