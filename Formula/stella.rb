# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.390 / @SHA_*@ placeholders below with
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
  version "0.9.390"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.390/stella-0.9.390-aarch64-apple-darwin.tar.gz"
      sha256 "c842c10e796fbf2ca246efe49b517bd626790cb829caed18d6ec67972b35a5f2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.390/stella-0.9.390-x86_64-apple-darwin.tar.gz"
      sha256 "193009bdbb46bafc1dd975bfea9d983df34d51b96767fd63157f017c68d37e94"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.390/stella-0.9.390-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d2589a081aa4387277785a26633316396bf01b428a1b94517b1258d375ad508e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.390/stella-0.9.390-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "643ae2bb326c685feb2a5bd913900a0ea0d4f92b7ae30154aed32aadc65ff6a1"
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
