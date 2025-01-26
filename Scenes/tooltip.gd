extends Control

# Desplazamiento del tooltip al entrar
const dy = 20
var gotitas = preload('res://Assets/ICONOS/AGUA2.png')

func decir(cosas):
	for cosa in cosas: 
		$Imagen.show()
		# Si es un símbolo
		if 'imagen' in cosa:
			$Imagen.texture = cosa['imagen']
		
		# Si es un txt
		else:
			$Label.text = cosa
		
		$burbujatiene.play()
		await tween_entrada()
		await get_tree().create_timer(0.4).timeout
		await tween_salida()
		$Imagen.hide()

func preguntar(cosas):
	for cosa in cosas: 
		$Imagen.show()
		
		if 'imagen' in cosa:
			$"¿".visible = true
			$Imagen.texture =  cosa['imagen'] 
			$"?".visible = true
		else:	
			$Label.text = '¿' + cosa + '?'
		$burbujaquiere.play()
		await tween_entrada()
		await get_tree().create_timer(0.4).timeout
		await tween_salida()
		$"¿".visible = false
		$"?".visible = false
		$Imagen.hide()
		
# `emocion` puede ser 'aburrimiento', 'amor', 'interrogación' o 'irritación'
func emocionar(emocion):
	$Emocion.show()
	await tween_entrada()
	$Emocion.play(emocion)
	await get_tree().create_timer(0.8).timeout
	await tween_salida()
	$Emocion.hide()
	
# Transiciona la entrada del tooltip... su opacidad y posición
func tween_entrada():
	modulate = Color.TRANSPARENT
	position = Vector2(position.x, -20)
	var t = create_tween()
	t.set_ease(Tween.EASE_OUT)
	t.set_trans(Tween.TRANS_EXPO)
	t.set_parallel()
	t.tween_property(self, "modulate", Color.WHITE, 0.2)
	t.tween_property(self, "position", Vector2(position.x, position.y - dy), 0.3)
	return t.finished

func tween_salida():
	var t = create_tween()
	t.set_ease(Tween.EASE_OUT)
	t.set_trans(Tween.TRANS_QUAD)
	t.tween_property(self, "modulate", Color.TRANSPARENT, 0.3)
	t.tween_property(self, "position", Vector2(position.x, position.y - dy), 0.3)
	return t.finished
