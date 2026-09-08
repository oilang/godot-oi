# build the extension into the demo project
build:
	oi build src/main.oi --lib -o demos/lib/liboi.so

# run the demo headless
run name: build
	godot --headless --path demos/{{name}} --quit

# open the demo in the editor
edit name: build
	godot --editor --path demos/{{name}}
