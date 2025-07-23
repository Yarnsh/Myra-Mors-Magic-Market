extends PanelContainer

@onready var label = $MetalBorder/Label

func display(text):
	label.text = text
	show()

func remove():
	hide()
