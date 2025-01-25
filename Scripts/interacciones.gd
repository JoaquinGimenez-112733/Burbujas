extends Node

var personajes_encontrados = []

func registrar_encuentro(npc: NPC):
	if not(npc in personajes_encontrados):
		personajes_encontrados.append(npc)
