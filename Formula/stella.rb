# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.41 / @SHA_*@ placeholders below with
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
  version "0.5.41"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.41/stella-0.5.41-aarch64-apple-darwin.tar.gz"
      sha256 "b831b08c770399145f81ac154d92f716a350e9bf514e6f3d5b73eeba1aafa842"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.41/stella-0.5.41-x86_64-apple-darwin.tar.gz"
      sha256 "4282cb7b7d3b34e869df28c6062d63defd187601086a764df7b96f20eb304858"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.41/stella-0.5.41-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d4389bc26f40772353af3cb69d04a49a65c3485a94607fd6e1f6763d030a50c8"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.41/stella-0.5.41-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fc00ac7e95a0ed575274aa912c818c9011c688cf8ccd3dcfc2caef0fbb7d8c78"
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
