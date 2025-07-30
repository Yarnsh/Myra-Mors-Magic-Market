extends Control

@onready var chores_label = $Chores
@onready var selections = $Selections

func populate(recipes):
	chores_label.text = ""
	for c in GameGlobals.current_chores:
		chores_label.text += c["name"]
		if c != GameGlobals.current_chores[-1]:
			chores_label.text += ", "
	
	for i in range(len(recipes)):
		selections.get_child(i).set_recipe_quiet(recipes[i])
