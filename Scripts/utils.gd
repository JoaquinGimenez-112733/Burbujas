extends Node

# Devuelve una sublista al azar, sin repeticiones. 
func pick_random(lista: Array, n: int):
	var dup = lista.duplicate()
	var res = []
	for i in range(n):
		var elem = dup.pop_at(randi_range(0, dup.size() - 1))
		res.append(elem)
	return res
	
# Devueve la intersección de dos listas. 
func interseccion(lista1: Array, lista2: Array):
	var elems = []
	for elem in lista1: 
		if elem in lista2:
			elems.append(elem)
	return elems
	
