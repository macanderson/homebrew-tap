# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.461 / @SHA_*@ placeholders below with
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
  version "0.9.461"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.461/stella-0.9.461-aarch64-apple-darwin.tar.gz"
      sha256 "2450621957f6daa25256254703dfb8b79638a6426634559bab64df84fe871e5a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.461/stella-0.9.461-x86_64-apple-darwin.tar.gz"
      sha256 "ae375b57f9acb23e5f65c1339b8d7d1de0067885e5c1be377e1624d8da3962a4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.461/stella-0.9.461-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a908226e6c4eb574a45716b2f2d9b2e0f994fe99a937c6f3be453cd340fb5b74"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.461/stella-0.9.461-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b7f4dc71ce6548697e4232fcbefe3085513d4a259731c0a503eccbe434d1b05e"
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
