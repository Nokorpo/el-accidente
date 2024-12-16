extends Button
## Button that changes the language of the project

const SUPPORTED_LANGUAGES := ["en", "es"]

func _ready() -> void:
	pressed.connect(_on_toggle_language_pressed)
	
	var current_language := TranslationServer.get_locale()
	if current_language not in SUPPORTED_LANGUAGES:
		TranslationServer.set_locale("es")
		_update_title("es")

func _on_toggle_language_pressed() -> void:
	match TranslationServer.get_locale():
		"en":
			TranslationServer.set_locale("es")
			_update_title("es")
		"es", _:
			TranslationServer.set_locale("en")
			_update_title("en")

func _update_title(lang_code: String) -> void:
	%Title.texture = load("res://assets/sprites/ui/main_menu_title_%s.png" % lang_code)
