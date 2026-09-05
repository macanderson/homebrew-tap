# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.345 / @SHA_*@ placeholders below with
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
  version "0.9.345"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.345/stella-0.9.345-aarch64-apple-darwin.tar.gz"
      sha256 "ed8a53fd88a1976a7de8ccb3b02f0891db92cafb68b6de8cb3cdf967463bff0b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.345/stella-0.9.345-x86_64-apple-darwin.tar.gz"
      sha256 "e99893a23c8495f0404f013543aa5964f9ad2d55bd4c8129f5f66f28f3bb9866"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.345/stella-0.9.345-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6708bc8154cae38016d440861f6a3fcf084f56276c34b609525b9edacbbe31c3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.345/stella-0.9.345-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "65b8e00d470b9380f507b262497054395af6484bc90e4c62a60cb8d11fcbfde2"
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
