# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.279 / @SHA_*@ placeholders below with
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
  version "0.9.279"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.279/stella-0.9.279-aarch64-apple-darwin.tar.gz"
      sha256 "d4710ba8144677fb3543c386e5c28a15075e616723d5d2123fcaeb235967b1e6"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.279/stella-0.9.279-x86_64-apple-darwin.tar.gz"
      sha256 "d52cca55358e8f5dfc9102da39c70db42417bd699145af49b9eedae8a75d202f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.279/stella-0.9.279-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5c6bad8a32372e1837886d13be337dc9e0780366093495322d3a35bb431f5323"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.279/stella-0.9.279-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "843826800a768109d472d4cee67837620a1f94f775264dd17cb8ee5c30a80d99"
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
