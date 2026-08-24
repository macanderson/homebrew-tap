# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.181 / @SHA_*@ placeholders below with
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
  version "0.9.181"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.181/stella-0.9.181-aarch64-apple-darwin.tar.gz"
      sha256 "02a5fc3a59f46b935cd6463bd7081822e1b16a5aebded7d91619fb73b183c14b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.181/stella-0.9.181-x86_64-apple-darwin.tar.gz"
      sha256 "94cea39cda2df1c47375be6d77e9a05d58c1382b353fe0b8863d2ba58f0bffab"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.181/stella-0.9.181-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "cb829ca8f620e4dd64a0b032915326e681b05c29620ce1101f3f6db5d8bccc9e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.181/stella-0.9.181-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a09373cc5b3028b232f668128fad826ce99592c2d2b79e0cefeee47f558ddccc"
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
