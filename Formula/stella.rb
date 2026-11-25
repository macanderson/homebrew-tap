# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.525 / @SHA_*@ placeholders below with
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
  version "0.9.525"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.525/stella-0.9.525-aarch64-apple-darwin.tar.gz"
      sha256 "9fecb661f0cba9fdd17f6c444b9d5f1cedecb9d76592aeb8bea0caf9f06fee50"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.525/stella-0.9.525-x86_64-apple-darwin.tar.gz"
      sha256 "985224e648543aa78b002a24b7191c59fae76175abb3c70c22beeb7d75332a61"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.525/stella-0.9.525-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7c99e14e9e67f90ec83faf6a5d341b0376e1de7f329235282ab3a8c68199338e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.525/stella-0.9.525-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f93dad8346f39150d4b4d062503dde3c46219cab4adb4eda34ac95a0fe9ba6ec"
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
