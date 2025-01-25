extends Control

func ubicar(pos: Vector2):
	$PopupPanel.position = pos

func activar(txt1: String, txt2: String, txt3: String):
	$PopupPanel.position = get_global_mouse_position() * Globals.player_camera_zoom
	$PopupPanel/VBoxContainer/Label.text = txt1
	$PopupPanel/VBoxContainer/Label2.text = txt2
	$PopupPanel/VBoxContainer/Label3.text = txt3
	$PopupPanel.popup()
	
func cerrar():
	$PopupPanel.hide()
