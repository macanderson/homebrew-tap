# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.145 / @SHA_*@ placeholders below with
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
  version "0.9.145"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.145/stella-0.9.145-aarch64-apple-darwin.tar.gz"
      sha256 "b5247cad6c79ae6caba08927d2dd59f40e0dc661692bbcdcb975989501f6f88c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.145/stella-0.9.145-x86_64-apple-darwin.tar.gz"
      sha256 "dc121a46e46282075cbbe9e12949e9815d66f946aa2a78fe816e8370b1a9a4da"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.145/stella-0.9.145-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0c7562ae9513e711b28b9d23be50b9f7da27d3005dd9e3c42fbcc38eefb80c2e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.145/stella-0.9.145-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8debd7649d99b23eda33cf68a1281ba47316fb194a92017d7357876404e56360"
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
