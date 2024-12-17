extends Button
## Button that changes the language of the project

const SUPPORTED_LANGUAGES := ["en", "es"]

static var _first_time_loading := true

func _ready() -> void:
	pressed.connect(_on_toggle_language_pressed)
	
	if _first_time_loading:
		var current_language := TranslationServer.get_locale()
		if current_language not in SUPPORTED_LANGUAGES:
			_set_locale(OS.get_locale_language())
		_first_time_loading = false

func _on_toggle_language_pressed() -> void:
	match TranslationServer.get_locale():
		"en":
			_set_locale("es")
		"es", _:
			_set_locale("en")

func _set_locale(lang_code: String) -> void:
	match lang_code:
		"en":
			TranslationServer.set_locale("en")
		"es", _:
			TranslationServer.set_locale("es")
