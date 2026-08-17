# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.74 / @SHA_*@ placeholders below with
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
  version "0.9.74"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.74/stella-0.9.74-aarch64-apple-darwin.tar.gz"
      sha256 "c461d840e51a5e9111b711af8e897322ead4f56bc651a964c36960aa432c3914"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.74/stella-0.9.74-x86_64-apple-darwin.tar.gz"
      sha256 "0c2f52cc32683d02bc7db3ed8b3079ecf4d98b3ab0b8bd8d01b3ac766a2278bc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.74/stella-0.9.74-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "bc5a9cd25726ac5580c510ac1cedc4b629582b959acd69c335931ef3e357c6a1"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.74/stella-0.9.74-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c7e7d0c36d28486ca5d91084a49d7b1205a53f3b94d9f0e1a5b0790015abc4fb"
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
