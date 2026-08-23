# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.156 / @SHA_*@ placeholders below with
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
  version "0.9.156"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.156/stella-0.9.156-aarch64-apple-darwin.tar.gz"
      sha256 "c4bc2b0469d28ba235e00bd8a55d6729329d47dcd270a816da19b2699b23ca76"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.156/stella-0.9.156-x86_64-apple-darwin.tar.gz"
      sha256 "fb80b4c004ac03368264aa07552df0e77d0bcbe83012a7a7f82a250310f32aab"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.156/stella-0.9.156-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2649a8ee1ff6bdc44c858e514b66d45b3df62087f5e08d795dde94f8326343c1"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.156/stella-0.9.156-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "330d3f499ab0b6897961375d4e54796047f7db60dbfa70283ff023df6ecb60d9"
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
