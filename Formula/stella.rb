# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.313 / @SHA_*@ placeholders below with
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
  version "0.9.313"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.313/stella-0.9.313-aarch64-apple-darwin.tar.gz"
      sha256 "c7c440a7f788eb5f7d3cdb29ccbcf831ee3e232b5de221a081290cc139caca4d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.313/stella-0.9.313-x86_64-apple-darwin.tar.gz"
      sha256 "21710fc4b77f61ae47b4993d5476ea82ed39f507984a30d18ca36ec5c5ec3a6c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.313/stella-0.9.313-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6e172422b1f31e5984f1d604606c359941b53c5889c495d9e2e5df2740defc85"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.313/stella-0.9.313-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a1c6b124f762ee389be981a8df0beed9a72296093d395de1e016c14b6ddf2aeb"
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
