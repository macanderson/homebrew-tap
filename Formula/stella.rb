# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.415 / @SHA_*@ placeholders below with
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
  version "0.9.415"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.415/stella-0.9.415-aarch64-apple-darwin.tar.gz"
      sha256 "eadfb044cea90f4e033fc1fab41ba8d9ae06b6f915d5edb7817eae5f304e4e78"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.415/stella-0.9.415-x86_64-apple-darwin.tar.gz"
      sha256 "54cf2a56ad7ad4ad58b021299ab5a78745a6240c1fe4f92432643734a97eaaa1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.415/stella-0.9.415-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "dc4a2c778eb5269e5d7f1de6ab7913a4335ef090003562cb0a2d62fc581e823d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.415/stella-0.9.415-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7c2d952dd2e38889c9cdaf467d045d78803156164c9dbdb63da90edb00990544"
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
