This repository is a collection of Aseprite LUA scripts written by myself [ObsidianBlk](https://github.com/ObsidianBlk).<D-Bslash>

## Scripts
### [OBS] Flatten to Layer
Will flatten an sprite into a new layer without altering the existing layers. Additionally the operation will run across all frames of the sprite.

#### Limitations:
* Does not properly handle per-cell opacity.
* May explode the current session's history (aka, cannot be undone by a single undo).

## License
All scripts are released under the [MIT License](./LICENSE.md).

