extends Node

func _ready() -> void:
	print("gd: can_instantiate ", ClassDB.can_instantiate("OiNode"), " is_node ", ClassDB.is_parent_class("OiNode", "Node"))
	print("gd: is_node2d ", ClassDB.is_parent_class("OiNode2D", "Node2D"))
	$OiNode.hello()
	print("gd: add ", $OiNode.add(1, 2))
	var n: OiNode = $OiNode
	print("gd: typed add ", n.add(3, 4))
	$OiNode.speed = 1.5
	print("gd: speed ", $OiNode.speed)
