# build an example's extension into its lib/
build name:
	oi build examples/{{name}}/src/init.oi --lib -o examples/{{name}}/lib/liboi.so

# run an example headless
run name: (build name)
	@test -f examples/{{name}}/.godot/extension_list.cfg || just import {{name}}
	godot --headless --path examples/{{name}} --quit

# let the editor register the extension
import name: (build name)
	godot --headless --path examples/{{name}} --import

# open an example in the editor
edit name: (build name)
	godot --editor --path examples/{{name}}
