# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.43 / @SHA_*@ placeholders below with
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
  version "0.6.43"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.43/stella-0.6.43-aarch64-apple-darwin.tar.gz"
      sha256 "2e9bf018b5c8e6ed7c38d37fe0e341f8e9cd77cb1b6e08040501eb5ae3d781d4"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.43/stella-0.6.43-x86_64-apple-darwin.tar.gz"
      sha256 "dda6292ac1da04efc6ebe4a33e885a467ad057db23bb81ecd05548e624891a4c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.43/stella-0.6.43-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "991d0e3695a25c397157a5fee889709f60c34431135ead7dceba3cd965711717"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.43/stella-0.6.43-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "39e702a54bd404c93b907668d9548de4c3632998ee6fad31e3aefc39d7c7ca91"
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
