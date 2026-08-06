# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.124 / @SHA_*@ placeholders below with
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
  version "0.6.124"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.124/stella-0.6.124-aarch64-apple-darwin.tar.gz"
      sha256 "4a083b555c03ea3f5efcbab938b944460a4a0625285e78840a4635364712f6ec"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.124/stella-0.6.124-x86_64-apple-darwin.tar.gz"
      sha256 "bdddb476c02af3c6802f6f2e9d4c1f7c75fe658afd1f916963f3fea76ddbda55"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.124/stella-0.6.124-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7ae2302073734cef479bcb84e707f174c5a3988f81fe60995f032be267715f0c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.124/stella-0.6.124-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7e03992e46555d84277e28b933e5e7e37377fb8931e3ae4f86e78c21def0de5d"
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
