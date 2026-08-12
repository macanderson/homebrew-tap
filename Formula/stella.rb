# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.13 / @SHA_*@ placeholders below with
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
  version "0.9.13"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.13/stella-0.9.13-aarch64-apple-darwin.tar.gz"
      sha256 "fa1f127cc94ce6d70b1eaa67071ff8b5646c90d5ad06ee507cba8e859aa70c06"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.13/stella-0.9.13-x86_64-apple-darwin.tar.gz"
      sha256 "bbb9e0fb6b2e2d70192dc5954b7f35c348257714a9f73c2966c68e02a7799510"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.13/stella-0.9.13-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "63b2beb90f0983d3630197d619b4f8e120ebbde443a2dcdef155dc764fc089d4"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.13/stella-0.9.13-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8fb2540b7a97d202531c6a85a683efd097ba4a6b8e6e778a173150c199762417"
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
