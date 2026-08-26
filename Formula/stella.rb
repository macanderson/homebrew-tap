# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.236 / @SHA_*@ placeholders below with
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
  version "0.9.236"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.236/stella-0.9.236-aarch64-apple-darwin.tar.gz"
      sha256 "6b123763ee083e6cf36a1d5b2dd9cb6e62a55f64e838373e38bb378d345d3dce"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.236/stella-0.9.236-x86_64-apple-darwin.tar.gz"
      sha256 "ec14f1ee8d5700689f3975a04028dba06b26e0aa7c496f8f1b21e45a586b155c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.236/stella-0.9.236-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ad3e9493ada500f4bc9d4e597756be4356e4022223b0db2656a96e84e096c900"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.236/stella-0.9.236-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "950c9979b87108c32c6a9bc496c9cbc05c2a816bc5bd15704fb6d700dcbb5204"
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
