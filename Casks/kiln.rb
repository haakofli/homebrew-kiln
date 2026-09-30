cask "kiln" do
  version "0.5.0"
  sha256 "0705daa5568e5f7dcfcd25c287768bc66c4778e7712d8f96044bae6fb3a27347"

  url "https://kiln-games.com/studio/download/#{version}/Kiln_#{version}_aarch64.dmg"
  name "Kiln"
  desc "Desktop app for building games by describing them"
  homepage "https://kiln-games.com/studio"

  # Kiln installs its own updates, so brew upgrade leaves it alone.
  auto_updates true
  depends_on arch: :arm64
  depends_on macos: ">= :big_sur"

  app "Kiln.app"

  # Ad-hoc signed, not notarized: without this Gatekeeper refuses to open it.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Kiln.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/games.kiln.studio",
    "~/Library/Caches/games.kiln.studio",
    "~/Library/Preferences/games.kiln.studio.plist",
    "~/Library/WebKit/games.kiln.studio",
  ]
end
