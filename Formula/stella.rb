# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.473 / @SHA_*@ placeholders below with
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
  version "0.9.473"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.473/stella-0.9.473-aarch64-apple-darwin.tar.gz"
      sha256 "048866ac3d49b5d8d5557c12baeff3722020a8bb3d8274d5bdf2d726626128f2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.473/stella-0.9.473-x86_64-apple-darwin.tar.gz"
      sha256 "b41ec1ea0529d6fc32c142ca131e7f4638628a675f331d30bb08ca483ff107da"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.473/stella-0.9.473-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "bfb8c3252df78a72d92478add21ad2911fe7e7c8bf4db3f3570ef96af0100680"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.473/stella-0.9.473-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "465caff5789a99856e0d90782cf1a765641c09b3dbdffb494e7fa5653c914791"
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
