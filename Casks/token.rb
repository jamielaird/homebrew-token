cask "token" do
  version "2.3.0"
  sha256 "be8eace1b1b0ce604767968f8915d3f716797657f0831bc8beb52895892aa188"

  url "https://github.com/jamielaird/homebrew-token/releases/download/v#{version}/Token-#{version}.zip"
  name "Token"
  desc "Menu-bar monitor for Claude Code and Codex CLI token usage"
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
