extends Button

# Este script define un botón mágico generado por código
# No usa imágenes, solo dibujo vectorial (_draw) y estilos (StyleBox)

@export var rune_color : Color = Color(0.4, 0.6, 1.0) # Color base de la runa

func _ready():
	# Configuramos el estilo base del botón para que sea invisible
	# y nosotros dibujemos encima
	add_theme_stylebox_override("normal", StyleBoxEmpty.new())
	add_theme_stylebox_override("hover", StyleBoxEmpty.new())
	add_theme_stylebox_override("pressed", StyleBoxEmpty.new())
	add_theme_stylebox_override("focus", StyleBoxEmpty.new())
	
	# Tamaño mínimo para que se vea la runa
	custom_minimum_size = Vector2(200, 60)

func _draw():
	var rect = Rect2(Vector2.ZERO, size)
	var center = size / 2.0
	var color = rune_color
	var line_width = 2.0
	
	if is_hovered():
		color = color.lightened(0.3)
		line_width = 4.0
		# Dibujamos un resplandor simple
		draw_rect(rect, Color(color, 0.1), true)
	
	if is_pressed():
		color = color.darkened(0.3)
		line_width = 1.0
	
	# Dibujamos un borde tipo "cristal" usando líneas
	draw_line(Vector2(0, 0), Vector2(size.x, 0), color, line_width)
	draw_line(Vector2(size.x, 0), Vector2(size.x, size.y), color, line_width)
	draw_line(Vector2(size.x, size.y), Vector2(0, size.y), color, line_width)
	draw_line(Vector2(0, size.y), Vector2(0, 0), color, line_width)
	
	# Dibujamos una pequeña marca mágica en las esquinas
	var s = 10.0
	draw_line(Vector2(0, 0), Vector2(s, s), color, line_width)
	draw_line(Vector2(size.x, 0), Vector2(size.x-s, s), color, line_width)
	draw_line(Vector2(size.x, size.y), Vector2(size.x-s, size.y-s), color, line_width)
	draw_line(Vector2(0, size.y), Vector2(s, size.y-s), color, line_width)
