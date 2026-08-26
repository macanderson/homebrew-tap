# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.240 / @SHA_*@ placeholders below with
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
  version "0.9.240"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.240/stella-0.9.240-aarch64-apple-darwin.tar.gz"
      sha256 "3e69b13db05fd803acbd360087d75c8120d232efdcd128d8e96b21617d699abf"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.240/stella-0.9.240-x86_64-apple-darwin.tar.gz"
      sha256 "953f17a97cf0e3a4cfe093e03fc69f41aef78bb8edf40e031b1a7d8c85cb1572"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.240/stella-0.9.240-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4968f44cb45611a0cd61377c517e84f67e1a643be0196bc17e7429478f4f32c5"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.240/stella-0.9.240-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b91ca416deadbb3a85b44c5cf50b733e83006eeff052a29b45a205cfed540c3f"
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
