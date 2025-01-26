extends Node2D

const npc_scene = preload('res://Scenes/npc.tscn')

# Solo para testear:
func _ready():

	$Test/Testita.nombre = 'Testita'
	$Test/Testita.dominio = 'naturaleza'
	$Test/Testita.tiene = Simbolos.simbolos_random_de('naturaleza', 2)
	$Test/Testita.quiere = Simbolos.simbolos_random_de('progreso', 1)
	$Test/Testita.aborrece = Simbolos.simbolos_random_de('arte', 1)
	$Test/Testita.encuentro.connect(manejar_encuentro)
	
	$Test/Testito.nombre = 'Testito'
	$Test/Testito.dominio = 'progreso'
	$Test/Testito.tiene = Simbolos.simbolos_random_de('progreso', 2)
	$Test/Testito.quiere = Simbolos.simbolos_random_de('arte', 1)
	$Test/Testito.aborrece = Simbolos.simbolos_random_de('naturaleza', 1)
	$Test/Testito.encuentro.connect(manejar_encuentro)
	
	$Test/Testite.nombre = 'Testite'
	$Test/Testite.dominio = 'arte'
	$Test/Testite.tiene = Simbolos.simbolos_random_de('arte', 2)
	$Test/Testite.quiere = Simbolos.simbolos_random_de('naturaleza', 1)
	$Test/Testite.aborrece = Simbolos.simbolos_random_de('progreso', 1)
	$Test/Testite.encuentro.connect(manejar_encuentro)
	

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
	npc.aborrece = aborrece
	npc.position = Navegacion.point_propio(dominio_propio)
	npc.dominio = dominio_propio
	
	npc.encuentro.connect(manejar_encuentro)
	
	add_child(npc)


func manejar_encuentro(npc1: NPC, npc2: NPC):
	print('@main manejando encuentro entre ', npc1.nombre, ' y ', npc2.nombre)
	
	npc1.interactuando = true
	npc2.interactuando = true
	
	var resultado = Interacciones.interactuar(npc1, npc2)
	for interaccion in resultado: 
		await Interacciones.despachar(interaccion)
		
	npc1.interactuando = false
	npc2.interactuando = false
	

var npcs = 0
func _on_spawn_timeout() -> void:
	if npcs < 60:
		crear_npc()
		npcs += 1
