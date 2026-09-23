# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.436 / @SHA_*@ placeholders below with
# the real version and per-target SHA-256 sums of the prebuilt tarballs, then
# commits the result to the tap repo (macanderson/homebrew-tap) as
# Formula/stella.rb. See .github/workflows/release.yml (the `homebrew` job).
#
# Unlike packaging/homebrew/stella.rb (which builds from source with cargo),
# this installs the prebuilt binary directly — no Rust toolchain required.
class Stella < Formula
  desc "Fast, BYOK, model-agnostic terminal coding agent"
  homepage "https://github.com/macanderson/stella"
  # Explicit version is kept intentionally: brew's URL version-scan is fragile
  # for filenames containing arch tokens (x86_64/aarch64), so we pin it.
  version "0.9.436"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.436/stella-0.9.436-aarch64-apple-darwin.tar.gz"
      sha256 "71e535cd922078a154d68196ba92fefb43242186597dbe9afbebfac1efd01026"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.436/stella-0.9.436-x86_64-apple-darwin.tar.gz"
      sha256 "f42f153e93ec084585d9c514bc4dade68d370ddfd4ff5a5511b7718b520ae368"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.436/stella-0.9.436-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "73da674318cf86dd7acab3ca94de65e2588dfc6233cb794866dc239c97c8f4ba"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.436/stella-0.9.436-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1f168665bee1af23f0741c693bf00f4b30252a5f6f8caa4cf25edce13aaea0eb"
    end
  end

  # Each tarball unpacks to a single stella-<version>-<target>/ directory that
  # Homebrew descends into automatically, so the binary is at the CWD root.
  def install
    bin.install "stella"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/stella --version")
  end
end
