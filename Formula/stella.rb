# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.54 / @SHA_*@ placeholders below with
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
  version "0.5.54"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.54/stella-0.5.54-aarch64-apple-darwin.tar.gz"
      sha256 "85df115bb040b9efcfbd068d8085575f0987c1375cb5dbf9708a18717de915b1"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.54/stella-0.5.54-x86_64-apple-darwin.tar.gz"
      sha256 "e86c44f79c65aca8077c0f67fec44bd05af8159f940f0e34413fde11afe6da76"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.54/stella-0.5.54-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "48b1192df67b02ad94d7638e1323d2935872dc89510cbe201891bdc5de607429"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.54/stella-0.5.54-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "39d846d831e5d0eb210b8b0511cc52aa9d6ec8b364d1bbe2793bda6a616d23a6"
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
