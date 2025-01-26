extends Node2D
class_name Item_Sidebar

var miniatura : Texture2D
var nombre    : String
var pos : Vector2
var guid : String

var array_imagenes : Array

func _init(miniatura, nombre, array_imagenes, pos, guid) -> void:
	self.miniatura = miniatura
	self.nombre    = nombre
	self.array_imagenes = array_imagenes
	self.pos = pos
	self.guid = guid
