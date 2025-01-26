extends Node2D


const npc_scene = preload('res://Scenes/npc.tscn')

func new_game():
	print("New game")
	$Spawn.start()
	$Player.show()
	
func crear_npc():
	#Generamos al azar un dominio propio, uno target y uno aborrecido
	#y agarramos dos simbolos propios y uno target, random
	var dominios = Simbolos.dominios_random(3)
	
	var dominio_propio = dominios[0]
	var dominio_quiere = dominios[1]
	var dominio_aborrece = dominios[2]
	
	var tiene = Simbolos.simbolos_random_de(dominio_propio, 2)
	var quiere = Simbolos.simbolos_random_de(dominio_quiere, 1)
	var aborrece = Simbolos.simbolos_random_de(dominio_aborrece, 1)
	
	var npc = npc_scene.instantiate()
	
	npc.nombre = Nombres.al_azar()
	npc.tiene = tiene
	npc.quiere = quiere
	npc.position = Navegacion.point_propio(dominio_propio)
	npc.dominio = dominio_propio
	
	add_child(npc)


var npcs = 0
func _on_spawn_timeout():
	print("Spawneando NPC")
	if npcs < 60:
		crear_npc()
		npcs += 1
