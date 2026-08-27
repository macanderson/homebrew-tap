# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.260 / @SHA_*@ placeholders below with
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
  version "0.9.260"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.260/stella-0.9.260-aarch64-apple-darwin.tar.gz"
      sha256 "2d0a4ab1f4f5135d3c0ad5c7a01b826d0a74d509b6ed31ba9fc948ba003845fb"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.260/stella-0.9.260-x86_64-apple-darwin.tar.gz"
      sha256 "029be44b0650305e4a425891f5326c30975f7c51d5ab874ff6906346db211b09"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.260/stella-0.9.260-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2c680e6ab940cc9e68883c82450c9b735bed9d1e6c8f699cf8cac8c5ea744eca"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.260/stella-0.9.260-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "62b98cc444ad80d2de9cf7b178a163dd0d0e455eb436a30b08b1d4563b6040d8"
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
