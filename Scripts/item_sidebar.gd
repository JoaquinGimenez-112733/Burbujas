extends Node2D
class_name Item_Sidebar

var miniatura : Texture2D
var nombre    : String

var array_imagenes : Array[CompressedTexture2D]

func _init(miniatura, nombre, array_imagenes) -> void:
	self.miniatura = miniatura
	self.nombre    = nombre
	self.array_imagenes = array_imagenes
