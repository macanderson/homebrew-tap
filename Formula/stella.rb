# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.285 / @SHA_*@ placeholders below with
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
  version "0.9.285"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.285/stella-0.9.285-aarch64-apple-darwin.tar.gz"
      sha256 "b7ca765de1d526b5cbd8b2a11aac0ea50b6b4be4c2c28b1bca90716014db8621"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.285/stella-0.9.285-x86_64-apple-darwin.tar.gz"
      sha256 "f1e5ff60f70f2ab71bab1e2a196e8077385dc9c0640378b9d41cd900b56acaf9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.285/stella-0.9.285-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f13792a4e06de8fa8383a4b86c5a6f489f76dcab16157464913c6f1cc1f7e02f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.285/stella-0.9.285-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "afce87f1aaa6cc6d487ed63df75aca3256322b5d5d8d26190effa4235f21ef42"
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
