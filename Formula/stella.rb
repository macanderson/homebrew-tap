# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.449 / @SHA_*@ placeholders below with
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
  version "0.9.449"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.449/stella-0.9.449-aarch64-apple-darwin.tar.gz"
      sha256 "271f5980fef8535ec784e12bad4d7b12fe9977a77fc91f5004f273726fdaafbe"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.449/stella-0.9.449-x86_64-apple-darwin.tar.gz"
      sha256 "75795aec4c041879692e761dd0d537f2cb35d3c08ab80a14fa388c9f8aec5910"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.449/stella-0.9.449-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2611e6ca3c8dbf584dca0adbf0f11053b241874786a1b4e10235cb9203945718"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.449/stella-0.9.449-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9bab07b8a3d3b5153c4fcc3192f6ac186544fe41c4bf6eb4a935ee7d8191d4a0"
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
