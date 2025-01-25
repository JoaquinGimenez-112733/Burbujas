extends Control
@onready var v_box_container: VBoxContainer = %VBoxContainer

var array_names : Array
var sidebar_open = false
var tween : Tween
func _ready() -> void:
	tween = Tween.new()
	#get_tree().root.add_child(tween)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for npc in Globals.items_sidebar:
		if npc.nombre not in array_names:
			var panel = PanelContainer.new()
			var margin = MarginContainer.new()
			
			const margin_size = 5
			margin.add_theme_constant_override("margin_top",margin_size)
			margin.add_theme_constant_override("margin_bottom",margin_size)
			margin.add_theme_constant_override("margin_left",margin_size)
			margin.add_theme_constant_override("margin_right",margin_size)
			
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
			margin.add_child(hbox)
			panel.add_child(margin)
			v_box_container.add_child(panel)
			
		array_names.append(npc.nombre)
