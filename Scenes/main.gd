extends Node2D


const npc_scene = preload('res://Scenes/npc.tscn')

func punto_random(collision_shape_2d: CollisionShape2D):
	var rect : Rect2 = collision_shape_2d.shape.get_rect()
	var x = randi_range(0, rect.size.x)
	var y = randi_range(0, rect.size.y)
	var rand_point = Vector2(x,y) 
	return rand_point

func crear_npc(pos: Vector2):
	#Generamos al azar un dominio propio y uno target
	#y agarramos dos simbolos propios y uno target, random
	var dominios = Simbolos.dominios_random(2)
	var dominio_propio = dominios[0]
	var dominio_quiere = dominios[1]
	var tiene = Simbolos.simbolos_random_de(dominio_propio, 2)
	var quiere = Simbolos.simbolos_random_de(dominio_quiere, 1)
	
	var npc = npc_scene.instantiate()
	
	npc.nombre = Nombres.al_azar()
	npc.tiene = tiene
	npc.quiere = quiere
	npc.position = pos
	
	add_child(npc)

func _ready() -> void:
	for i in range(100):
		crear_npc(punto_random($Mapa/AreaNat/CollisionShape2D))
		
