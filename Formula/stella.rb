# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.277 / @SHA_*@ placeholders below with
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
  version "0.9.277"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.277/stella-0.9.277-aarch64-apple-darwin.tar.gz"
      sha256 "859d60cbdd80e4fccd2f574470b205c64bd79a2c8a7ed62de83ae2ba75ee16b2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.277/stella-0.9.277-x86_64-apple-darwin.tar.gz"
      sha256 "30d163bda430f83bc7f6bcc9105c297ff22d88cca2f96afd362f3c9967e0b273"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.277/stella-0.9.277-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8d9375efea3ef3de8c9b4ddd9c73f669f7341cc98ec2ee8be7b122284bc482fd"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.277/stella-0.9.277-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e29ce48c12647a1365a365c9ec9bdec87fcbf91c9a6480cb88fa9b7a6565d4ff"
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
