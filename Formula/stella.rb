# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.8.39 / @SHA_*@ placeholders below with
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
  version "0.8.39"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.39/stella-0.8.39-aarch64-apple-darwin.tar.gz"
      sha256 "d3f19fc4e15a8ecc177f8f8a11f335cac11c7d98d6e60a80187f9e9f3734101b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.39/stella-0.8.39-x86_64-apple-darwin.tar.gz"
      sha256 "006735c2e9a0edf3616fb0bdc845d0fe210ec21834d25789b29bae0c78b22c8c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.39/stella-0.8.39-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "29414adebc63eb6b4e774ce5bca761399c7258997207504b9c6d67e58ba30698"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.39/stella-0.8.39-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3dea36bc49265549dbe149a80438894d6225e7ddad161bab1a0a59cc09d1771e"
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
