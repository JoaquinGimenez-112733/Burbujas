extends Node

# Archivo con variables globales, que tienen 
# que ser accedidas por varias escenas

var player_camera_zoom = 1
const max_players_selected = 2
var player_selecteds = 0

var selected_npc : NPC = null
var npcs : Array[NPC] = []
