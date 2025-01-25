extends Control
@onready var player: CharacterBody2D = $"../Player"
@onready var v_box_container: VBoxContainer = $VBoxContainer
var size_sidebar = 0
var array_names : Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#for npc in Globals.npcs:
		#var label = Label.new()
		#var hbox = HBoxContainer.new()
		#hbox.add_child(label)
		#label.text = npc.nombre
		#$VBoxContainer.add_child(hbox)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for npc in Globals.npcs:
		
		if npc not in array_names:		
			var label = Label.new()
			label.text = npc
			v_box_container.add_child(label)
		array_names.append(npc)
