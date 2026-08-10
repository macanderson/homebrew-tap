# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.8.37 / @SHA_*@ placeholders below with
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
  version "0.8.37"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.37/stella-0.8.37-aarch64-apple-darwin.tar.gz"
      sha256 "3f6c30d5a4f429dafe7d8dd8ec13be8d28c0fd50e558d3e01b42c42979aea3a8"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.37/stella-0.8.37-x86_64-apple-darwin.tar.gz"
      sha256 "a17706c424e344e38a6d6ecaa18e684a81be92dda5d25a9ad66616a776507cdf"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.37/stella-0.8.37-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "068ff40d9450f0c44ede0670eaa8d1b2fbb7342507db66b61f1a8135f0d8cf5c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.37/stella-0.8.37-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "325dabbb267486fb59c4a1e606bb51cc10ee4c371a7c887b46d6a61620d3a1c3"
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
