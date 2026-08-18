# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.94 / @SHA_*@ placeholders below with
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
  version "0.9.94"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.94/stella-0.9.94-aarch64-apple-darwin.tar.gz"
      sha256 "8a1d124ac7f657f073ef2cc2608437638531191b865b0f83b6a028346c56c822"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.94/stella-0.9.94-x86_64-apple-darwin.tar.gz"
      sha256 "18e1d322e5215245aec1b8e074eed2d078f8b41d688136db4d06c0ce0c164ab3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.94/stella-0.9.94-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a3e0710f2d9859776bc331e3948ff2689a2fbdfb4a68db0959685aafccc451a2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.94/stella-0.9.94-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "84a3e56d25929fab94fe5e4a8dc7c96b3d0457eeab86367f020c3f3ddf55f12a"
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
