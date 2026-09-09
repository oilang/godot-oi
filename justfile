# build a demo's extension into its lib/
build name:
	oi build demos/{{name}}/src/init.oi --lib -o demos/{{name}}/lib/liboi.so

# run a demo headless
run name: (build name)
	@test -f demos/{{name}}/.godot/extension_list.cfg || just import {{name}}
	godot --headless --path demos/{{name}} --quit

# let the editor register the extension
import name: (build name)
	godot --headless --path demos/{{name}} --import

# open a demo in the editor
edit name: (build name)
	godot --editor --path demos/{{name}}
