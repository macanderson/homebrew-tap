# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.352 / @SHA_*@ placeholders below with
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
  version "0.9.352"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.352/stella-0.9.352-aarch64-apple-darwin.tar.gz"
      sha256 "394dc489399ad07835a5fcd16f468b2f3d2f0f4a0ef53fad199d96ba0f290cff"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.352/stella-0.9.352-x86_64-apple-darwin.tar.gz"
      sha256 "0c58f10425797f7e482c0db1e8351d219878c9974bc5da67c08740c5ed897d6c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.352/stella-0.9.352-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "47785e5fd1c2e59635ed9673bdf49e881362a1ec53d43e2c9709a5a526da9ff4"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.352/stella-0.9.352-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a1239720d12f58bbf659b0029fb15b3e65ebf58cef6f17d24d1fd22d6be7541c"
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
