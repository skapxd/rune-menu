extends Control

@onready var main_container = $MainContainer
@onready var save_container = $SaveContainer
@onready var name_entry_container = $NameEntryContainer

@onready var buttons_container = $MainContainer/VBoxContainer/ButtonsVBox
@onready var saves_container = $SaveContainer/VBoxContainer/SavesHBox
@onready var back_button = $SaveContainer/VBoxContainer/BackButton

@onready var name_edit = $NameEntryContainer/VBoxContainer/NameEdit
@onready var confirm_button = $NameEntryContainer/VBoxContainer/ConfirmButton

var selected_slot_index : int = -1
var slot_buttons : Array[Button] = []

const RuneButton = preload("res://scripts/rune_button.gd")

func _ready():
	# Configurar botones menú principal
	create_menu_button("PLAY", Color(0.4, 0.8, 0.4), _on_play_pressed)
	create_menu_button("GRIMOIRE", Color(0.4, 0.6, 1.0), Callable())
	create_menu_button("EXIT", Color(0.9, 0.3, 0.3), get_tree().quit)
	
	# Configurar botón de regreso
	back_button.set_script(RuneButton)
	back_button.rune_color = Color(0.6, 0.6, 0.6)
	back_button.pressed.connect(_on_back_pressed)
	
	# Configurar confirmación de nombre
	confirm_button.set_script(RuneButton)
	confirm_button.rune_color = Color(0.4, 0.8, 0.4)
	confirm_button.pressed.connect(_on_confirm_ritual_pressed)
	
	# Crear slots de partida (Losas)
	for i in range(3):
		create_save_slot(i)

func create_menu_button(label_text: String, color: Color, callback: Callable = Callable()):
	var btn = Button.new()
	btn.text = label_text
	btn.set_script(RuneButton)
	btn.rune_color = color
	buttons_container.add_child(btn)
	
	if not callback.is_null():
		btn.pressed.connect(callback)

func create_save_slot(index: int):
	var btn = Button.new()
	btn.text = "SLOT " + str(index + 1) + "\n[EMPTY]"
	btn.set_script(RuneButton)
	btn.rune_color = Color(0.8, 0.7, 0.5) # Color piedra
	btn.custom_minimum_size = Vector2(250, 350) # Formato vertical (Losa)
	saves_container.add_child(btn)
	slot_buttons.append(btn)
	
	btn.pressed.connect(_on_slot_pressed.bind(index))

func _on_slot_pressed(index: int):
	selected_slot_index = index
	# Por ahora, si está vacío (que siempre lo están), vamos a inscripción
	transition_to(name_entry_container)
	name_edit.grab_focus()

func _on_confirm_ritual_pressed():
	var player_name = name_edit.text
	if player_name.strip_edges() == "":
		player_name = "Wizard " + str(selected_slot_index + 1)
	
	# Actualizar la losa con el nombre
	var slot_btn = slot_buttons[selected_slot_index]
	slot_btn.text = player_name + "\n[LEVEL 1]"
	slot_btn.rune_color = Color(0.5, 0.9, 0.9) # Cambiar a color "activado"
	
	# Regresar a la selección de slots
	transition_to(save_container)
	name_edit.text = ""

func _on_play_pressed():
	transition_to(save_container)

func _on_back_pressed():
	transition_to(main_container)

func transition_to(target_container: Control):
	var tween = create_tween().set_parallel(true)
	
	# Definir todas las pantallas posibles
	var all_screens = [main_container, save_container, name_entry_container]
	
	for c in all_screens:
		if c == target_container:
			c.visible = true
			tween.tween_property(c, "modulate:a", 1.0, 0.3)
			tween.tween_property(c, "position:y", 0.0, 0.3).from(20.0)
		else:
			# Solo animamos el que estaba visible
			if c.visible:
				var t = create_tween()
				t.tween_property(c, "modulate:a", 0.0, 0.3)
				t.tween_callback(c.set_visible.bind(false))