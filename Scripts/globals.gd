extends Node

# Archivo con variables globales, que tienen 
# que ser accedidas por varias escenas

var player_camera_zoom = 5
const max_players_selected = 2
var player_selecteds = 0

var npcs : Array[NPC] = []
var miniaturas : Array[TextureRect] = []
var items_sidebar : Array[Item_Sidebar] = []
