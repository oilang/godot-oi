# godot-oi

Oi bindings for Godot.

- `godot/` is the module a game imports with `use godot`
- `templates/` has files meant to be symlinked/copied into your project
- `examples/` are Godot projects

# setup

```sh
# installs godot module into `$OI_HOME/lib`
just install
```

# run

```sh
just run bare
```

Requires `oi` and `godot` (4.5+).

# TODO

- make an executable that does stuff like scaffolding
- wrap types
