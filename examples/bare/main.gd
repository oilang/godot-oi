extends Node


func _ready() -> void:
	print(
		"gd: can_instantiate ",
		ClassDB.can_instantiate("OiNode"),
		" is_node ",
		ClassDB.is_parent_class("OiNode", "Node"),
	)
	print("gd: is_node2d ", ClassDB.is_parent_class("OiNode2D", "Node2D"))

	$OiNode.hello()
	print("gd: add ", $OiNode.add(1, 2))

	var n: OiNode = $OiNode
	print("gd: typed add ", n.add(3, 4))
	print("gd: add4 ", $OiNode.add4(1, 2, 3, 4), " ", n.add4(5, 6, 7, 8))
	print("gd: default speed ", ClassDB.class_get_property_default_value("OiNode", "speed"))

	for p in ClassDB.class_get_property_list("OiNode", true):
		if p.name in ["speed", "scene"]:
			print("gd: hint ", p.hint, " ", p.hint_string)
	$OiNode.speed = 1.5
	print("gd: speed ", $OiNode.speed)
	print("gd: frames ", $OiNode.frames)
	print("gd: has_method tag ", ClassDB.class_has_method("OiNode", "tag"))

	var bits = ClassDB.is_class_enum_bitfield("OiNode2D", "Layers")
	print("gd: enum ", OiNode.Mode.FAST, " ", OiNode.SLOW, " ", OiNode2D.Layers.WATER, " ", bits)
	print("gd: has_signal ", ClassDB.class_has_signal("OiNode2D", "hit"))

	$OiNode2D.hit.connect(
		func(damage):
			print("gd: hit ", damage),
	)
	$OiNode2D.fire(7)

	$OiNode2D.hp += 2
	print("gd: hp ", $OiNode2D.hp)

	$OiNode2D.aim += Vector2(1, 1)
	print("gd: aim ", $OiNode2D.aim)

	var before = $OiNode2D.label
	$OiNode2D.label += " there"
	print("gd: label ", before, " ", $OiNode2D.label)

	var empty = $OiNode2D.loot
	$OiNode2D.loot = "gold"
	var loot = ClassDB.class_get_property_list("OiNode2D", true).filter(
		func(p):
			return p.name == "loot",
	)[0]
	print("gd: loot ", empty, " ", $OiNode2D.loot, " ", loot.usage & PROPERTY_USAGE_NIL_IS_VARIANT != 0)

	var m: OiNode2D = $OiNode2D
	print("gd: doubled ", $OiNode2D.doubled(Vector2(1, 2)), " ", m.doubled(Vector2(3, 4)))
	print("gd: greet ", $OiNode2D.greet("dyn"), " ", m.greet("typed"))
	print("gd: echo ", $OiNode2D.echo([1, "a"]), " ", m.echo(Vector2(1, 2)), " ", m.echo(null))

	$OiNode2D.armor += 1
	print("gd: flat ", $OiNode2D.armor, " ", $OiNode2D.reach, " ", m.shout(["a", "b"]), " ", m.hp_of($OiNode2D))

	$OiNode2D.notification(9001)
	print("gd: to_string ", $OiNode2D)
