extends Button

const SUPPORTED_LANGUAGES = ["en", "es"]

func _ready():
	self.pressed.connect(_on_toggle_language_pressed)
	
	var current_language = TranslationServer.get_locale()
	if current_language not in SUPPORTED_LANGUAGES:
		TranslationServer.set_locale("es")

func _on_toggle_language_pressed():
	match TranslationServer.get_locale():
		"en":
			TranslationServer.set_locale("es")
		"es":
			TranslationServer.set_locale("en")
		_:
			TranslationServer.set_locale("es")
