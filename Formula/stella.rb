# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.387 / @SHA_*@ placeholders below with
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
  version "0.9.387"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.387/stella-0.9.387-aarch64-apple-darwin.tar.gz"
      sha256 "01726016eaa6f629b349cd42a762a73e50265fec58fbbda2c402f9727578e1ea"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.387/stella-0.9.387-x86_64-apple-darwin.tar.gz"
      sha256 "e363242671fdc7b40587a681eda66784aada4eb0df658cd7539bb7eafaf76f38"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.387/stella-0.9.387-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6300befe2619203ca89d2229d53d5c7baaa3a2796ce9e37afb66cda61ba4f25b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.387/stella-0.9.387-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "36150288521ecf4f75752eb7aa0d56c5fc27b8610b1171bfb133c320e0befcfc"
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
