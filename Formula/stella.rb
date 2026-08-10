# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.8.28 / @SHA_*@ placeholders below with
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
  version "0.8.28"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.28/stella-0.8.28-aarch64-apple-darwin.tar.gz"
      sha256 "2392c05073853359efc19617514816b2e7389a6f1c6ab1bdecfdfd46f4c5dedf"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.28/stella-0.8.28-x86_64-apple-darwin.tar.gz"
      sha256 "35bb1aa7597b136c873883476ace9180dbbf77fae82d00e3de4b6941aadcf5c1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.28/stella-0.8.28-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "132ae4a43bd92b4505378c5e432984eec891b5435fa895d32f9f459c24fd5511"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.28/stella-0.8.28-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "26d970bb59d359e7b59892ca1dc9c6d056a0c05be2cda442e1ae67d253a6ab6a"
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
