# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.293 / @SHA_*@ placeholders below with
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
  version "0.9.293"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.293/stella-0.9.293-aarch64-apple-darwin.tar.gz"
      sha256 "e3af23cbb7763f7a3c2c7c7a021cfc2fb80af1ed3f77ddb9abd324349d63868c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.293/stella-0.9.293-x86_64-apple-darwin.tar.gz"
      sha256 "ea16d1ee7acaa2533f3fd2f69583fb01f4e49d9336648ba53200cc4f8796a3dd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.293/stella-0.9.293-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "af3b5e4e8f16f19f56348d55ded5856802058509017c2bf4a5260a86560cf3d7"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.293/stella-0.9.293-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "35aab5dffad16ea28ad1cadde1eba3a0e84f1cce78277cebf38163b4bdd4032b"
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
