# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.8.12 / @SHA_*@ placeholders below with
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
  version "0.8.12"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.12/stella-0.8.12-aarch64-apple-darwin.tar.gz"
      sha256 "425f9aaa77cc7bc814c8556e3013ca4373d63a35747526634e3f9357b3dd2dee"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.12/stella-0.8.12-x86_64-apple-darwin.tar.gz"
      sha256 "c8f3504b978325d938ace17501a6db75d39960e3174661598f0e77170c512854"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.12/stella-0.8.12-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "136b40734aae7e89b469d3a2c6dabf370e99065ca61eebeeb6a361ac367bc663"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.12/stella-0.8.12-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ede7df417569d166a64078c62f6056d5b1bc822194ca52c978d1345d99f140fd"
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
