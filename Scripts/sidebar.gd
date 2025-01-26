extends CanvasLayer
@onready var v_box_container: VBoxContainer = %VBoxContainer

var array_names : Array
var sidebar_open = false

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
			var portrait_button = TextureButton.new()
			portrait_button.stretch_mode = TextureButton.STRETCH_KEEP_CENTERED			
			portrait_button.texture_normal = npc.miniatura
			for n in Globals.npcs:
				if n.guid == npc.guid:							
					portrait_button.pressed.connect(Callable(self,"_on_button_pressed").bind(n))
					break
			hbox.add_child(portrait_button)
			
			var vbox_labels = VBoxContainer.new()
			var label  = Label.new()
			label.text = npc.nombre		
			var hboxImagenes = HBoxContainer.new()
			var index : int	
			index += 1
			for imagen in npc.array_imagenes:
				
				var textureButton = TextureButton.new()
				for n in Globals.npcs:
					if n.guid == npc.guid:							
						textureButton.pressed.connect(Callable(self,"_on_button_pressed").bind(n))
						break				
				#textureButton.pressed.connect(Callable(self,"_on_button_pressed").bind(npc.nombre))
				textureButton.stretch_mode = TextureButton.STRETCH_KEEP_CENTERED
				textureButton.texture_normal = imagen.imagen
				var texture1 = TextureRect.new()
				texture1.stretch_mode =TextureRect.STRETCH_KEEP_CENTERED			
				texture1.texture = imagen.imagen
				hboxImagenes.add_child(textureButton)

			
			vbox_labels.add_child(label)
			vbox_labels.add_child(hboxImagenes)
			hbox.add_child(vbox_labels)
			margin.add_child(hbox)
			panel.add_child(margin)
			v_box_container.add_child(panel)
			
		array_names.append(npc.nombre)
		
func _on_button_pressed(npc_clickeado):
	if Globals.selected_npc:
		Globals.selected_npc.ir_a(npc_clickeado)
		Globals.selected_npc.deshighlight()
		Globals.selected_npc = null
