# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.65 / @SHA_*@ placeholders below with
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
  version "0.9.65"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.65/stella-0.9.65-aarch64-apple-darwin.tar.gz"
      sha256 "ae3ae92031c97e3864e68e81026f94377acffb4b21144073153c77a255eb3df0"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.65/stella-0.9.65-x86_64-apple-darwin.tar.gz"
      sha256 "0f32fb64c502b18bf5df43263328b38f3d4f029cc0a2e4296b3e31bbecaee920"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.65/stella-0.9.65-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f89133a68646b7fa4758dae37d9abda415a88648ae2cbc6f0d050a3c522b0b4e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.65/stella-0.9.65-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e304d4dbbdfb6fb15344dcbe01815cfdcc6207f71992cd9188a7d322ff285550"
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
