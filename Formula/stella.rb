# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.214 / @SHA_*@ placeholders below with
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
  version "0.9.214"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.214/stella-0.9.214-aarch64-apple-darwin.tar.gz"
      sha256 "5cc5762a4b99887da0ad9a34ec25f74c4d2a185532ab20eee0cb1e5ee5a06705"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.214/stella-0.9.214-x86_64-apple-darwin.tar.gz"
      sha256 "0f3a6fec9051dad2e7c8246cbdb739fe20f94653ac2de99619203197a11fd305"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.214/stella-0.9.214-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "68d570522cfac4f5f29b117df89265c7e04b4523c96feae517d72a60f9c1ddf5"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.214/stella-0.9.214-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f963ea6de7749bcd5fc34b3eb5428046cac117e689de37ec998b9e31a837e5ed"
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
