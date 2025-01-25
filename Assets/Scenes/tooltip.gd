extends Control

# Desplazamiento del tooltip al entrar
const dy = 20

func decir(txts):
	for txt in txts: 
		$Label.text = txt
		await tween_entrada()
		await get_tree().create_timer(1.5).timeout
		await tween_salida()

func preguntar(txts):
	for txt in txts: 
		$Label.text = '¿' + txt + '?'
		await tween_entrada()
		await get_tree().create_timer(1.5).timeout
		await tween_salida()
		
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
