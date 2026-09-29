cask "kiln" do
  version "0.4.0"
  sha256 "5a4913758d2155e84efcef8f50828bd65c247a0cc280ee2f167a222ab01ad5cd"

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
