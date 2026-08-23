# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.147 / @SHA_*@ placeholders below with
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
  version "0.9.147"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.147/stella-0.9.147-aarch64-apple-darwin.tar.gz"
      sha256 "d2ecb0e0953e2941ab3ddecbdb7c9bcba373c5881ade7d44be22746f33dea67c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.147/stella-0.9.147-x86_64-apple-darwin.tar.gz"
      sha256 "5dc602c589ae20049e618e63952ceb59164f4bf23c6922d7b4679da4f40f45a2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.147/stella-0.9.147-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e279ad3e2e0f3f09c9cfd1a70d4d158bab56233ae30c89e70e2052491d2ca7e0"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.147/stella-0.9.147-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "01dfb72724d88208252a49b84859983fa0a524b1ce586753fe67cdf062071d88"
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
