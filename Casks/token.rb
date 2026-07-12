cask "token" do
  version "3.3.0"
  sha256 "64bf79c046930d721ecaacafd698ea66cab6ead83b6efbb267a397ce5fff8f5a"

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
