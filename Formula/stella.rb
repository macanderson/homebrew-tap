# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.176 / @SHA_*@ placeholders below with
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
  version "0.9.176"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.176/stella-0.9.176-aarch64-apple-darwin.tar.gz"
      sha256 "1f85af630221af222b594c0356424a79c8d2afb10810ca805ab252c5dc5845c0"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.176/stella-0.9.176-x86_64-apple-darwin.tar.gz"
      sha256 "3e924d932ee67c63a3753624b3b4d6b5954dd630f88ef7c61220a7d43fde817b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.176/stella-0.9.176-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "da10cf16f8270af5fa1ba8dc489e8e29d000dd7f09922d4cda279a610c7f9a14"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.176/stella-0.9.176-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "63082fc47791d6c58b61225163e9405579a3d1bf62d15a12eac209cf92ffc674"
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
