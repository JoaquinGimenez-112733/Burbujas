extends Node2D

# Dibuja tipo un diagrama de Venn que representa qué tan alineadas
# están entre sí las "burbujas" que estén seteadas. Cada burbuja es
# una cantidad de símbolos de los disponibles de la lista de símbolos,
# y cada burbuja estaría representando un personaje.

var simbolos = ['📯', '📿', '🪢']
var colores = [Color.BROWN, Color.DARK_ORANGE, Color.LAWN_GREEN]
#var burbujas = ['📯📯📯', '📿🪢📿', '🪢🪢📿']
var burbujas = ['📯🪢🪢', '📯🪢📿', '📯🪢']
var polos = [] 

var default_font = ThemeDB.fallback_font
var default_font_size = 48
	
var diametro = 150

func _ready():
	update()

func update():
	# Calculamos las posiciones de los "polos"
	polos = []
	for simbolo in simbolos:
		var a = simbolos.find(simbolo) * TAU / simbolos.size()
		polos.append(diametro * Vector2.from_angle(a))

func posiciones():
	
	var ps = [] 
	
	for burbuja in burbujas:
		var pos = Vector2.ZERO
		for simbolo in burbuja: 
			pos += polos[simbolos.find(simbolo)] / 3
		ps.append(pos)
	
	return ps

func _draw():
	draw_circle(Vector2.ZERO, 140, Color(Color.GRAY, 0.4))

	# Dibujamos cada círculo en su posición
	var centros = posiciones()
	for i in centros.size():
		draw_circle(centros[i], 80, Color(colores[i], 0.4))
		
	# Dibujamos los símbolos
	for i in simbolos.size():
		draw_circle(polos[i], 35, Color(Color.WHITE,0.2))
		draw_string(default_font, polos[i] + Vector2(-24, 24), simbolos[i], HORIZONTAL_ALIGNMENT_LEFT, -1, default_font_size)
	

	
