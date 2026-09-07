# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.388 / @SHA_*@ placeholders below with
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
  version "0.9.388"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.388/stella-0.9.388-aarch64-apple-darwin.tar.gz"
      sha256 "9512ec306d4d1d31931958cee67a85b87c0277729a66589f215352a306902324"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.388/stella-0.9.388-x86_64-apple-darwin.tar.gz"
      sha256 "16a3279a3f894396ee299206f68e2848a64aefe799388f27da5cef04ce928f73"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.388/stella-0.9.388-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fed8a88afcf6c0c58cee536f3b51603cc74e0df8b3c8631c4ed038c73f7825fb"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.388/stella-0.9.388-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5a87af1943f461e914419f4e1e56b51e53d61964330da3b36466bb29a1384188"
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
