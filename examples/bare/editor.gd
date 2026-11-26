extends SceneTree


func _init() -> void:
	var game = ClassDB.instantiate("OiNode")
	var node = ClassDB.instantiate("OiTool")
	print("gd: editor ", Engine.is_editor_hint(), " ", game.call("add", 1, 2), " ", node.ping())
	game.free()
	node.free()
	quit()
