extends Node

# Listas con los markers de cada dominio
var points = {
	'naturaleza' : [],
	'progreso' : [],
	'arte' : [],
}

func point_propio(dominio: String):
	return Utils.pick_uno(points[dominio])
	
func point_extranjero(dominio: String):
	var posibles = points.keys()
	posibles.erase(dominio)
	var clave = Utils.pick_uno(posibles)
	return Utils.pick_uno(points[clave])
