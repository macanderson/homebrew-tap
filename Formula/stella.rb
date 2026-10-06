# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.485 / @SHA_*@ placeholders below with
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
  version "0.9.485"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.485/stella-0.9.485-aarch64-apple-darwin.tar.gz"
      sha256 "b4ef1fb6bcddc822517772f8e961284497affee4bbac26d8273106301a3afab4"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.485/stella-0.9.485-x86_64-apple-darwin.tar.gz"
      sha256 "ae9db18d0241bdeb78a13a664ccd31c1f596225f309afeb0d7fb91c68b7c4513"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.485/stella-0.9.485-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fee113998b1239365ea89b76aceb78dbac8c943ffeb3be1503a68c2a337de1ab"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.485/stella-0.9.485-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1b3b59d1c966c9fa8abf8ccf9009c7b9c7f9c5d2a4db1d097de24d934bdf3d39"
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
