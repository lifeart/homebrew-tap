# lifeart/homebrew-tap

Homebrew casks for [MDv](https://lifeart.github.io/md-view/), a markdown viewer
for macOS.

```sh
brew install --cask lifeart/tap/md-view
```

Installing by the full name trusts this one cask (Homebrew's
[tap trust](https://docs.brew.sh/Tap-Trust)), so later a plain `brew upgrade`
keeps it current along with everything else. If you use a `Brewfile`:

```ruby
cask "lifeart/tap/md-view", trusted: true
```

Apple silicon, macOS 12 or later. It installs the same notarized DMG as the
[releases page](https://github.com/lifeart/md-view/releases).

MDv stays running after you close its window, so `brew upgrade` quits it
before swapping in the new version and reopens it afterwards. If you'd rather
it didn't, use `brew upgrade --no-quit`: the old version keeps serving opens
until you quit it.

## How the cask stays current

The `version` and `sha256` in [`Casks/md-view.rb`](Casks/md-view.rb) are not
edited by hand. MDv's release workflow publishes the notarized DMG, downloads
it back from the release, hashes what GitHub serves, and pushes the new values
here (`scripts/update-cask.sh` in the md-view repository). That push triggers
this repository's CI, which installs the cask on a clean macOS runner, so every
release is checked through `brew` before anyone runs `brew upgrade`.

Everything else in the cask (`zap` paths, `depends_on`) is edited here.
