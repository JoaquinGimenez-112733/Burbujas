extends Control
@onready var player: CharacterBody2D = $"../Player"
@onready var v_box_container: VBoxContainer = %VBoxContainer

var array_names : Array
var sidebar_open = false

func _ready() -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for npc in Globals.items_sidebar:
		if npc.nombre not in array_names:
			var hbox = HBoxContainer.new()
			var texture_rect = TextureRect.new()
			texture_rect.stretch_mode =TextureRect.STRETCH_KEEP_CENTERED			
			texture_rect.texture = npc.miniatura
			hbox.add_child(texture_rect)
			
			var vbox_labels = VBoxContainer.new()
			var label  = Label.new()			
			var label2 = Label.new()	
			label.text = npc.nombre
			label2.text = npc.stat1 + "-" + npc.stat2 + "-" + npc.stat3
			vbox_labels.add_child(label)
			vbox_labels.add_child(label2)
			hbox.add_child(vbox_labels)
			v_box_container.add_child(hbox)
		array_names.append(npc.nombre)
	#for npc in Globals.npcs:
		#
		#if npc not in array_names:		
			#var label = Label.new()
			#label.text = npc
			#v_box_container.add_child(label)
		#array_names.append(npc)
