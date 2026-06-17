cask "token" do
  version "2.0.0"
  sha256 "ae1061b1a1d890c03614ab35f639c81419e08357517a50daeeace2edde374f9c"

  url "https://github.com/jamielaird/homebrew-token/releases/download/v#{version}/Token-#{version}.zip"
  name "Token"
  desc "Menu-bar monitor for Claude Code usage, plan quota, and AI API spend"
  homepage "https://github.com/jamielaird/token"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Token.app"

  # Token is ad-hoc signed (not notarized), so strip the download quarantine
  # after install — otherwise macOS Gatekeeper blocks the first launch.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Token.app"]
  end

  zap trash: [
    "~/Library/Preferences/app.token.Token.plist",
    "~/Library/Preferences/app.quota.Quota.plist",
  ]
end
