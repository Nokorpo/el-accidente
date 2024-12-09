extends Camera2D
## Follows the player character

@export var player: Player

func _ready() -> void:
	pass #call_deferred("init")

func init():
	var dup: Camera2D = self.duplicate()
	get_parent().add_child(dup)
	
	var sub: SubViewport = SubViewport.new()
	get_parent().get_parent().add_child(sub)
	get_parent().reparent(sub)

func _process(_delta: float) -> void:
	self.global_position = lerp(self.global_position, player.global_position, .9)
