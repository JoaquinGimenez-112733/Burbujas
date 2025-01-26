extends CanvasLayer
@onready var v_box_container: VBoxContainer = %VBoxContainer

var array_names : Array
var sidebar_open = false

var items_sidebar = []

func generar_panel(item: Item_Sidebar):
	
	# Crear panel
	var panel = PanelContainer.new()
	var margin = MarginContainer.new()
	
	#Configurar margenes
	const margin_size_sides = 40
	const margin_size = 5
	margin.add_theme_constant_override("margin_top",margin_size)
	margin.add_theme_constant_override("margin_bottom",margin_size)
	margin.add_theme_constant_override("margin_left",14)
	margin.add_theme_constant_override("margin_right",margin_size_sides)
	
	# Hbox base
	var hbox = HBoxContainer.new()
	var portrait_button = TextureButton.new()
	portrait_button.stretch_mode = TextureButton.STRETCH_KEEP_CENTERED
	portrait_button.SIZE_EXPAND_FILL

	portrait_button.custom_minimum_size = Vector2(14,14)			
	portrait_button.texture_normal = item.miniatura
	
	# Event listener
	for n in Globals.npcs:
		if n.guid == item.guid:							
			portrait_button.pressed.connect(Callable(self,"_on_button_pressed").bind(n))
			break
	
	# Agregar el portrait al hbox
	hbox.add_child(portrait_button)
	
	var vbox_labels = VBoxContainer.new()
	var label  = Label.new()
	label.text = item.nombre		
	var hboxImagenes = HBoxContainer.new()
	
	var index : int	
	index += 1
	####QUIERE
	for imagen_quiere in item.array_quiere:
		var texture1 = textura_para(imagen_quiere)
		hboxImagenes.add_child(texture1)
	
	######TIENE	
	var hboxImagenesTiene = HBoxContainer.new()
	for imagen_tiene in item.array_tiene:
		var texture1 = textura_para(imagen_tiene)
		hboxImagenesTiene.add_child(texture1)
		
	######ABORRECE
	var hboxImagenesAborrece = HBoxContainer.new()
	for imagen_aborrece in item.array_aborrece:
		var texture1 = textura_para(imagen_aborrece)
		hboxImagenesAborrece.add_child(texture1)
	
	vbox_labels.add_child(label)
	vbox_labels.add_child(hboxImagenes)
	vbox_labels.add_child(hboxImagenesTiene)
	vbox_labels.add_child(hboxImagenesAborrece)
	hbox.add_child(vbox_labels)
	margin.add_child(hbox)
	panel.add_child(margin)
	
	return panel

func textura_para(imagen):
	var texture = TextureRect.new()
	texture.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED	
	texture.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
	texture.size_flags_horizontal = true
	texture.size_flags_vertical   = true
	texture.custom_minimum_size = Vector2(14,14)		
	texture.texture = imagen.imagen
	return texture

func update():
	print("Updateando sidebar con ", Globals.npcs)
	print(Globals.npcs.map(npc_a_sidebar_item))
	items_sidebar = Globals.npcs.map(npc_a_sidebar_item)
	
	# Clear v_box_container
	for child in v_box_container.get_children():
		child.queue_free()
	
	# Cargarlo con el nuevo status
	for item in items_sidebar:
		v_box_container.add_child(generar_panel(item))
	
func npc_a_sidebar_item(npc: NPC) -> Item_Sidebar:
	var animated_sprite = npc.get_node("AnimatedSprite2D")
	var frame = animated_sprite.get_frame()
	var miniatura : Texture2D = animated_sprite.sprite_frames.get_frame_texture("idle_small", 0)
	return Item_Sidebar.new(miniatura, npc.nombre, npc.quiere, npc.tiene, npc.aborrece, npc.global_position, npc.guid)
	
func _on_button_pressed(npc_clickeado):
	if Globals.selected_npc:
		Globals.selected_npc.ir_a(npc_clickeado)
		Globals.selected_npc.deshighlight()
		Globals.selected_npc = null
