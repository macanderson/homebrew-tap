# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.62 / @SHA_*@ placeholders below with
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
  version "0.5.62"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.62/stella-0.5.62-aarch64-apple-darwin.tar.gz"
      sha256 "f23d3c5774e814c23b5b765b81b9dc66264e160c8bbfc93382126b4f3015cac5"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.62/stella-0.5.62-x86_64-apple-darwin.tar.gz"
      sha256 "921a9c3320479b9b00e6f60f4e6824db8c1076b3331fee7a045d8dae96abc5e9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.62/stella-0.5.62-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "12be334ddd8d17ff479171265fc7c7916ce26d27a01a67c773f41f78e0de73e4"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.62/stella-0.5.62-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "586564a72eee6031f53f0cbf289bff3368d2d18e5aae0eb18b79f0f21f69eabb"
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
