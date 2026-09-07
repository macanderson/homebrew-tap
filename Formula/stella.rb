# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.396 / @SHA_*@ placeholders below with
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
  version "0.9.396"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.396/stella-0.9.396-aarch64-apple-darwin.tar.gz"
      sha256 "916f8db3ac3604049352af6fa6c8d6d056a05403babef0afa6c3ec0bf4bd3df6"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.396/stella-0.9.396-x86_64-apple-darwin.tar.gz"
      sha256 "860384342420019c73f534722cbe74fd6ada032f7edefa934d85dde3a5920e3d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.396/stella-0.9.396-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "412df7040a736f5273b8ba84abc161afb5d653a0fdcc82190febf23b1d99cc3f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.396/stella-0.9.396-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "30c5a54e39f954fc5c1fe50ee199962581eb0271d7f7128856533b45885ffe1f"
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
