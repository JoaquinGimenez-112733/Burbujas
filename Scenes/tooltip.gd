extends Control

# Desplazamiento del tooltip al entrar
const dy = 20
var gotitas = preload('res://Assets/ICONOS/AGUA.png')

func decir(cosas):
	for cosa in cosas: 
		
		# Si es un símbolo
		if 'imagen' in cosa:
			$Imagen.texture = cosa['imagen']
		
		# Si es un txt
		else:
			$Label.text = cosa
		
		await tween_entrada()
		await get_tree().create_timer(1.5).timeout
		await tween_salida()

func preguntar(cosas):
	for cosa in cosas: 
		
		if 'imagen' in cosa:
			$"¿".visible = true
			$Imagen.texture =  cosa['imagen'] 
			$"?".visible = true
		else:	
			$Label.text = '¿' + cosa + '?'
		await tween_entrada()
		await get_tree().create_timer(1.5).timeout
		await tween_salida()
		$"¿".visible = false
		$"?".visible = false
		
# Transiciona la entrada del tooltip... su opacidad y posición
func tween_entrada():
	modulate = Color.TRANSPARENT
	position = Vector2(position.x, -20)
	var t = create_tween()
	t.set_ease(Tween.EASE_OUT)
	t.set_trans(Tween.TRANS_QUAD)
	t.tween_property(self, "modulate", Color.WHITE, 0.3)
	t.tween_property(self, "position", Vector2(position.x, position.y - dy), 0.3)
	return t.finished

func tween_salida():
	var t = create_tween()
	t.set_ease(Tween.EASE_OUT)
	t.set_trans(Tween.TRANS_QUAD)
	t.tween_property(self, "modulate", Color.TRANSPARENT, 0.3)
	t.tween_property(self, "position", Vector2(position.x, position.y - dy), 0.3)
	return t.finished
