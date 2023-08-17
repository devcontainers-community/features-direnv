# direnv Dev Container Feature

📁 Installs direnv and sets up hooks

<!--<p align=center>
  <img width=400 src=https://i.imgur.com/7On7iXn.png>
</p>-->

## Usage

```jsonc
// devcontainer.json
{
  "features": {
    "ghcr.io/devcontainers-community/features/direnv": {}
  }
}
```

❓ Don't know what this ☝ means? Check out [this VS Code blog post].

### Options

You can set `version` to one of `latest`, `system`, or `N.N.N` to pin a specific version:

```jsonc
// devcontainer.json
{
  "features": {
    "ghcr.io/devcontainers-community/features/direnv": {
      "version": "1.0.0"
    }
  }
}
```

<!-- prettier-ignore -->
[this vs code blog post]: https://code.visualstudio.com/blogs/2022/09/15/dev-container-features
