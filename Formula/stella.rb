# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.34 / @SHA_*@ placeholders below with
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
  version "0.5.34"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.34/stella-0.5.34-aarch64-apple-darwin.tar.gz"
      sha256 "493be79d98699cafd5cd463410bdf0b9cfc9d5c57b2a738f4bb5a117e5f72482"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.34/stella-0.5.34-x86_64-apple-darwin.tar.gz"
      sha256 "31e8ae83697dd32cbabd399ac8773ca04353e32f43b351a19bd6c2967735c47e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.34/stella-0.5.34-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "bb9f6ef5b9d68b4b723aab2113e9b44c9439cda7652bcec2c427345a8ad3139f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.34/stella-0.5.34-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b8669d433417fb4c268ba054afe3ec0211b24d45f755f8a306c2c78f4426117a"
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
