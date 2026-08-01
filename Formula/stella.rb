# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.58 / @SHA_*@ placeholders below with
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
  version "0.6.58"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.58/stella-0.6.58-aarch64-apple-darwin.tar.gz"
      sha256 "6bf011892f8dd62e2af2f01e9af99d7e9804c1e7df85af7477d51b76003bda05"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.58/stella-0.6.58-x86_64-apple-darwin.tar.gz"
      sha256 "19d64f20f2314621c6ad6154ac80e105cc4af24abd08b5e8a6083c013be856c3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.58/stella-0.6.58-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3697f069354adda13eaf523b86adfbe28f47efbd78f941692f15a49d30a8ac07"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.58/stella-0.6.58-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "bfdcc1e09f824547fa5d93967cbaa62c8c64313fd76ca8e4defbeb4b9c28f79e"
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
