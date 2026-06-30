cask "token" do
  version "3.0.0"
  sha256 "79e902c47eb72243cff0b5c7d467d993da586b5babc83df2a4449eab7a2122c4"

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
