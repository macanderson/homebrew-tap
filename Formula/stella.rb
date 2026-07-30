# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.8 / @SHA_*@ placeholders below with
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
  version "0.6.8"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.8/stella-0.6.8-aarch64-apple-darwin.tar.gz"
      sha256 "fc34ab392303beb84df7329171b21859057e6f50554c4daf17e88d00428a7b9d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.8/stella-0.6.8-x86_64-apple-darwin.tar.gz"
      sha256 "0d59fcd04f60bd0d47c328e7a49b7772f7b30401ca6a25bb659fce0d8526b82d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.8/stella-0.6.8-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f958fa9f4ab2081d3602ee8af9d9657d3a3a6f7397ef50e6e91f094e43e27237"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.8/stella-0.6.8-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1ff8810c9e6b44144566a5f919914458a1b97c8a2444671d030ddb2dd6531af6"
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
