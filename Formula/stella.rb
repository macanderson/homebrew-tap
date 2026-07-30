# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.5 / @SHA_*@ placeholders below with
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
  version "0.6.5"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.5/stella-0.6.5-aarch64-apple-darwin.tar.gz"
      sha256 "04089abb82637a48b80a867742a30b7b0b93f41704ea491a52e0adbff5846f4d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.5/stella-0.6.5-x86_64-apple-darwin.tar.gz"
      sha256 "63d6f375ef748f3be55679d3a8cfb42321738fbcec1710c26cf65d61d53b1a7d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.5/stella-0.6.5-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3089a3a48f6212cbdb71fb9c0e5dc0314290dec49f75e1a779a73114b5df2bad"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.5/stella-0.6.5-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "127d00e761951da89fbc6b96e11b8800376a7ec703da8bdef6c1acf1a6f00b73"
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
