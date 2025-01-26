extends Node2D
class_name Item_Sidebar

var miniatura : Texture2D
var nombre    : String
var pos : Vector2
var guid : String

var array_imagenes : Array
var array_quiere : Array
var array_tiene : Array
var array_aborrece : Array

func _init(miniatura, nombre, quiere, tiene, aborrece, pos, guid) -> void:
	self.miniatura = miniatura
	self.nombre    = nombre
	#self.array_imagenes = array_imagenes
	self.array_quiere   = quiere
	self.array_tiene    = tiene
	self.array_aborrece = aborrece
	self.pos = pos
	self.guid = guid
