# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.187 / @SHA_*@ placeholders below with
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
  version "0.9.187"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.187/stella-0.9.187-aarch64-apple-darwin.tar.gz"
      sha256 "e472aa167410a85ff2f59862a63939fc0105696f143c1f745b967f04b8681bed"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.187/stella-0.9.187-x86_64-apple-darwin.tar.gz"
      sha256 "f0efd602cc6696af76293be9b6ec001dbb0bb8a023ce1ea5b664b25606b6852d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.187/stella-0.9.187-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3db1233a24209dfc7d2175b72ca6bd640d1780e9a4e0feb7e8fbd64e8e35ea94"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.187/stella-0.9.187-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e3409a92e711a305da1a6f5ba837809d17744b1936658bd9114dba9f7642d6f0"
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
