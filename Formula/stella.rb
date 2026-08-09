# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.8.13 / @SHA_*@ placeholders below with
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
  version "0.8.13"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.13/stella-0.8.13-aarch64-apple-darwin.tar.gz"
      sha256 "e3bb57f8542b0fcda7a20f905262bbbc391deac1dbfa1360dd8d05c7f3b128fd"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.13/stella-0.8.13-x86_64-apple-darwin.tar.gz"
      sha256 "46593d03037d866cf50837efb5d3b25dd2dab9093065a6a1389ffc66e7642114"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.13/stella-0.8.13-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c90d1138d2713e1b638cb776f26a41a2df86e88fd047916a5d4c18ec32f6f747"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.13/stella-0.8.13-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e2b9a0d16523c88163784f3a7a33b86660638d8f64de209623b34c0ff7f98a93"
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
