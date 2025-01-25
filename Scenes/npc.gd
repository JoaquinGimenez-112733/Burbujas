extends CharacterBody2D

var focused = false
var hablando = false
var tiene = ['a', 'b']
var quiere = ['c']

func _process(delta: float) -> void:
	queue_redraw()

func _ready():
	$AnimatedSprite2D.play("idle")

func _on_area_tooltip_mouse_entered() -> void:
	focused = true
	if not(hablando):
		hablando = true
		await $Tooltip.decir(tiene)
		await $Tooltip.preguntar(quiere)
		hablando = false

func _on_area_tooltip_mouse_exited() -> void:
	focused = false

func _draw():
	if focused:
		draw_circle(Vector2.ZERO, 30, Color.WHITE, false)
