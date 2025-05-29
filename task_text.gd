extends PanelContainer

@onready var label = $Label

func display(text):
	label.text = text
	show()

func remove():
	hide()
