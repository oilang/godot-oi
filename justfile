home := env("OI_HOME", env("HOME") / ".oi")
oi := env("OI", "oi")

# link godot module into OI_HOME
install:
	{{oi}} install godot --link

# dump extension_api.json from Godot
# pass `docs` to keep the doc strings
api mode="":
	cd godot && godot --headless --dump-extension-api{{ if mode == "docs" { "-with-docs" } else { "" } }}
	{{oi}} run gen

# build an example's extension into its lib/
build name:
	@test -e {{home}}/lib/godot || just install
	@test -d godot/api || just api
	{{oi}} build examples/{{name}}/src/init.oi --lib -o examples/{{name}}/lib/liboi.so

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
