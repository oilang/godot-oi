oi := env("OI", "oi")

# dump extension_api.json from Godot
# pass `docs` to keep the doc strings
api mode="":
	cd godot && godot --headless --dump-extension-api{{ if mode == "docs" { "-with-docs" } else { "" } }}
	{{oi}} run gen
	{{oi}} exec < godot/api_sizes.check

# build an example's extension into its lib/
build name:
	@test -f godot/api_index.json || just api
	{{oi}} build examples/{{name}}/src --lib -o examples/{{name}}/lib/liboi.so

# run an example headless
run name: (build name)
	@test -f examples/{{name}}/.godot/extension_list.cfg || just import {{name}}
	godot --headless --path examples/{{name}} --quit

# build an example opted into `libgodot.host!()` as an executable running Godot off $LIBGODOT, then run it headless
host name: (build name)
	{{oi}} build examples/{{name}}/src -o examples/{{name}}/lib/oi
	examples/{{name}}/lib/oi --headless --path examples/{{name}} --quit

# let the editor register the extension
import name: (build name)
	godot --headless --path examples/{{name}} --import

# open an example in the editor
edit name: (build name)
	godot --editor --path examples/{{name}}

# diff an example's smoke output, then editor.gd's stdout under the editor, against its expected.txt
# pass `host` to diff the same through `just host` (needs $LIBGODOT)
test name mode="":
	{ just run {{name}}; godot --headless --editor --path examples/{{name}} -s res://editor.gd 2>/dev/null; } 2>&1 | just _expect {{name}}
	if [ "{{mode}}" = host ]; then \
		{ just host {{name}}; examples/{{name}}/lib/oi --headless --editor --path examples/{{name}} -s res://editor.gd 2>/dev/null; } 2>&1 \
			| just _expect {{name}}; \
	fi

# keep stdin's oi:/gd:/WARNING: lines minus `oi: process` and diff them against an example's expected.txt
_expect name:
	@grep -E '^(oi|gd|WARNING): ' | grep -v '^oi: process ' \
		| sed -E 's/Godot [0-9]+\.[0-9]+\.[0-9]+.*/Godot x.y.z/' | diff -u examples/{{name}}/expected.txt -
