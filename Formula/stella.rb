# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.339 / @SHA_*@ placeholders below with
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
  version "0.9.339"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.339/stella-0.9.339-aarch64-apple-darwin.tar.gz"
      sha256 "297cc6e1b1e8eb09c6a6cf70d59136e9389f973ea179d4e25e430f361c9cad93"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.339/stella-0.9.339-x86_64-apple-darwin.tar.gz"
      sha256 "695ada4c071a7c401746e5fdacff487bf7173fa2bad4945ff7b99af412fa1914"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.339/stella-0.9.339-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3e6a8cd9d8d7e50b03ba5f510e0176c387235b34c85027c0d5bc82e922a78afd"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.339/stella-0.9.339-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "46baebf1c885243ded36710384d099c916780a93471a3628e205786bd38fc362"
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
