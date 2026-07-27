# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.55 / @SHA_*@ placeholders below with
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
  version "0.5.55"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.55/stella-0.5.55-aarch64-apple-darwin.tar.gz"
      sha256 "3366ecb0ec80045f93de9e67d713a178d5b4a839ed5a1e1214fc3b5602593cfd"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.55/stella-0.5.55-x86_64-apple-darwin.tar.gz"
      sha256 "55df38648b51c954fba9fd45b154ac6ced78e34d76a5f20efe3cdd69245926c3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.55/stella-0.5.55-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0ecbffb7f776c6aa846f06a0cb600664c9956512dd4d5c41088d45c63c1920d0"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.55/stella-0.5.55-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ca4eaaf18c6b3a88144ed58a8d6c3a776fc55902ffa9e5732e057725abbf41cc"
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
