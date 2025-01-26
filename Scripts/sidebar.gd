extends CanvasLayer
@onready var v_box_container: VBoxContainer = %VBoxContainer

var array_names : Array
var sidebar_open = false

func _process(delta: float) -> void:
	for npc in Globals.items_sidebar:
		if npc.nombre not in array_names:
			var panel = PanelContainer.new()
			var margin = MarginContainer.new()
			
			const margin_size_sides = 40
			const margin_size = 5
			margin.add_theme_constant_override("margin_top",margin_size)
			margin.add_theme_constant_override("margin_bottom",margin_size)
			margin.add_theme_constant_override("margin_left",14)
			margin.add_theme_constant_override("margin_right",margin_size_sides)
			
			var hbox = HBoxContainer.new()
			var portrait_button = TextureButton.new()
			portrait_button.stretch_mode = TextureButton.STRETCH_KEEP_CENTERED
			portrait_button.SIZE_EXPAND_FILL

			portrait_button.custom_minimum_size = Vector2(14,14)			
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
			####QUIERE
			for imagen in npc.array_quiere:

				#var textureButton = TextureRect.new()
				for n in Globals.npcs:
					if n.guid == npc.guid:							
						#textureButton.pressed.connect(Callable(self,"_on_button_pressed").bind(n))
						break				
				#textureButton.pressed.connect(Callable(self,"_on_button_pressed").bind(npc.nombre))
				#textureButton.stretch_mode = TextureButton.STRETCH_KEEP_CENTERED
				#textureButton.expand_mode = 1
				#textureButton.texture = imagen.imagen
				var texture1 = TextureRect.new()
				texture1.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED	
				texture1.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
				texture1.size_flags_horizontal = true
				texture1.size_flags_vertical   = true	
				texture1.custom_minimum_size = Vector2(14,14)
				texture1.texture = imagen.imagen
				
				hboxImagenes.add_child(texture1)
			
			######TIENE	
			var hboxImagenesTiene = HBoxContainer.new()
			for imagen_tiene in npc.array_tiene:
				
				#var textureButton = TextureRect.new()
				for n in Globals.npcs:
					if n.guid == npc.guid:							
						#textureButton.pressed.connect(Callable(self,"_on_button_pressed").bind(n))
						break				
				
				#textureButton.stretch_mode = TextureButton.STRETCH_KEEP_CENTERED
				#textureButton.texture_normal = imagen_tiene.imagen
				#textureButton.expand_mode = 1
				var texture1 = TextureRect.new()
				texture1.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED	
				texture1.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL	
				texture1.size_flags_horizontal = true
				texture1.size_flags_vertical   = true	
				texture1.custom_minimum_size = Vector2(14,14)
				texture1.texture = imagen_tiene.imagen
				
				hboxImagenesTiene.add_child(texture1)
				
			######ABORRECE
			var hboxImagenesAborrece = HBoxContainer.new()
			for imagen_aborrece in npc.array_aborrece:
				
				#var textureButton = TextureRect.new()
				for n in Globals.npcs:
					if n.guid == npc.guid:							
						#textureButton.pressed.connect(Callable(self,"_on_button_pressed").bind(n))
						break				
				
				#textureButton.stretch_mode = TextureButton.STRETCH_KEEP_CENTERED
				#textureButton.texture_normal = imagen_aborrece.imagen
				var texture1 = TextureRect.new()
				texture1.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED	
				texture1.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
				texture1.size_flags_horizontal = true
				texture1.size_flags_vertical   = true
				texture1.custom_minimum_size = Vector2(14,14)		
				texture1.texture = imagen_aborrece.imagen
				hboxImagenesAborrece.add_child(texture1)								

			
			vbox_labels.add_child(label)
			vbox_labels.add_child(hboxImagenes)
			vbox_labels.add_child(hboxImagenesTiene)
			vbox_labels.add_child(hboxImagenesAborrece)
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
