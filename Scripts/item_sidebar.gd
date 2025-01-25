extends Node2D
class_name Item_Sidebar

var miniatura : Texture2D
var nombre    : String
var stat1 :String
var stat2 :String
var stat3 :String

func _init(miniatura, nombre, stat1, stat2, stat3) -> void:
	self.miniatura = miniatura
	self.nombre    = nombre
	self.stat1 = stat1
	self.stat2 = stat2
	self.stat3 = stat3
