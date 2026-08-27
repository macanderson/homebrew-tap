# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.261 / @SHA_*@ placeholders below with
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
  version "0.9.261"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.261/stella-0.9.261-aarch64-apple-darwin.tar.gz"
      sha256 "2296ec417ac1bd07bc3ebd892b918cf5e9dc6568c53e877e5b95618ba18a1946"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.261/stella-0.9.261-x86_64-apple-darwin.tar.gz"
      sha256 "f4d01470d06380a83748ff7e793716c4b2345a31db32e62161185721e4cd066e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.261/stella-0.9.261-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5e985ba4ec3991f89e74446f478a4f0d954c220b6b80510afdafa6cd8974800a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.261/stella-0.9.261-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6e65d97a2e685674a8778493d9145d48d0d341c01c3bf07c37167ec84bff3e55"
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
