extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_progress_body_entered(body: Node2D) -> void:
	$AreaProgress/AudioStreamPlayer2D.play()
	
func _on_area_progress_body_exited(body: Node2D) -> void:
	$AreaProgress/AudioStreamPlayer2D.stop()


func _on_area_art_body_entered(body: Node2D) -> void:
	$AreaArt/AudioStreamPlayer2D.play()
	
func _on_area_art_body_exited(body: Node2D) -> void:
	$AreaArt/AudioStreamPlayer2D.stop()


func _on_area_nat_body_entered(body: Node2D) -> void:
	$AreaNat/AudioStreamPlayer2D.play()


func _on_area_nat_body_exited(body: Node2D) -> void:
	$AreaNat/AudioStreamPlayer2D.stop()
