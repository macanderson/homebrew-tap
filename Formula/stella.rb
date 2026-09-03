# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.324 / @SHA_*@ placeholders below with
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
  version "0.9.324"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.324/stella-0.9.324-aarch64-apple-darwin.tar.gz"
      sha256 "f8a3a29738e7af59abc71257c2471b59469d1d7fd1af31864ce74c95ec6817ca"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.324/stella-0.9.324-x86_64-apple-darwin.tar.gz"
      sha256 "db7a726a3d682346456459326e44ec2cce63ac9996fe2d9e808dfde70fcc0265"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.324/stella-0.9.324-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b54e9e38321b2feb09f8180e0c96bf3dca009dc61b2dca753b084d3ac8fde258"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.324/stella-0.9.324-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "82946edf52368652d637b640c20ffb8853c4dcbfa3cf129e25c1256391a616a9"
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
