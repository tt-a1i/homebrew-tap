class AgentsMarket < Formula
  desc "Agent-native marketplace and installer for specialized coding subagents"
  homepage "https://tt-a1i.github.io/agents-market/"
  # Pinned to the commit behind the preview-0.1.0 release; switch to the npm
  # registry tarball once @agents-market/cli is published.
  url "https://github.com/tt-a1i/agents-market/archive/1aac352c0cb99e7b2920c185365b41ed9c8ae4e4.tar.gz"
  version "0.1.0"
  sha256 "48ad996e0936a95c0eaf329e92e90a0770063955663d4742afb834b526ccb0c5"
  license "MIT"

  depends_on "node"

  def install
    # local install first so devDependencies are present for the prepack
    # build + registry lint that run during the global install
    system "npm", "install"
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match "agents-market", shell_output("#{bin}/agents-market --help")
    output = shell_output("#{bin}/agents-market list --json")
    assert_match "starter-dev-pack", output
  end
end
