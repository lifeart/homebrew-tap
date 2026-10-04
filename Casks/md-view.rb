cask "md-view" do
  # version and sha256 are rewritten by md-view's release workflow
  # (scripts/update-cask.sh) once the notarized DMG is published.
  version "0.4.0"
  sha256 "d6a4a82e47c9bfe2d2f2edac4f9aac3c1e0901f172b905ebf6253c9097f7ca4b"

  url "https://github.com/lifeart/md-view/releases/download/v#{version}/md-view-#{version}.dmg"
  name "MDv"
  desc "Markdown viewer with GitHub-flavored rendering"
  homepage "https://lifeart.github.io/md-view/"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Release builds are arm64 only. The Quick Look extension targets macOS 12,
  # and Go 1.25 (what the app is built with) requires it.
  depends_on arch: :arm64
  depends_on macos: :monterey

  app "MDv.app"

  # MDv stays resident after its window closes (and starts hidden at login if
  # the reader opted into prewarming), so an upgrade would otherwise leave the
  # old version serving every open until the next Cmd+Q or logout.
  uninstall quit: "com.wails.md-view"

  zap trash: [
    "~/Library/Application Scripts/com.wails.md-view.quicklook",
    "~/Library/Application Support/md-view",
    "~/Library/Caches/com.wails.md-view",
    "~/Library/Containers/com.wails.md-view.quicklook",
    "~/Library/Preferences/com.wails.md-view.plist",
    "~/Library/WebKit/com.wails.md-view",
  ]
end
