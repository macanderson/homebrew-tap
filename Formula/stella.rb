# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.431 / @SHA_*@ placeholders below with
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
  version "0.9.431"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.431/stella-0.9.431-aarch64-apple-darwin.tar.gz"
      sha256 "fda1861a91b905f56cf12b1a486583f1be0be15145a2b975b20bf871d144094a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.431/stella-0.9.431-x86_64-apple-darwin.tar.gz"
      sha256 "bcbcb7abbb96a5deffb8b0f0411a33e9d1307d3653b79d4ec2120706723890a7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.431/stella-0.9.431-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a56741e5e2e7e27d9c537ce628a7019ef44238fe5b66fa8eb47859752e9d153b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.431/stella-0.9.431-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0c1fb7076a587e9b22b3737d2d1013a36cdbe7eeaab180983567910bcaf5b8b3"
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
