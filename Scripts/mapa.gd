extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for marker in $Markers/Naturaleza.get_children():
		Navegacion.points['naturaleza'].append(marker.position)
	for marker in $Markers/Progreso.get_children():
		Navegacion.points['progreso'].append(marker.position)
	for marker in $Markers/Arte.get_children():
		Navegacion.points['arte'].append(marker.position)


func _on_area_progress_body_entered(body: Node2D) -> void:
	if body is Player:
		$AreaProgress/AudioStreamPlayer2D.play()
	
func _on_area_progress_body_exited(body: Node2D) -> void:
	if body is Player:
		$AreaProgress/AudioStreamPlayer2D.stop()


func _on_area_art_body_entered(body: Node2D) -> void:
	if body is Player:
		$AreaArt/AudioStreamPlayer2D.play()
	
func _on_area_art_body_exited(body: Node2D) -> void:
	if body is Player:
		$AreaArt/AudioStreamPlayer2D.stop()


func _on_area_nat_body_entered(body: Node2D) -> void:
	if body is Player:
		$AreaNat/AudioGlobalNat.play()


func _on_area_nat_body_exited(body: Node2D) -> void:
	if body is Player:
		$AreaNat/AudioGlobalNat.stop()


func _on_area_art_area_entered(area: Area2D) -> void:
	$AreaArt/AudioStreamPlayer2D.play()


func _on_area_art_area_exited(area: Area2D) -> void:
	$AreaArt/AudioStreamPlayer2D.stop()
