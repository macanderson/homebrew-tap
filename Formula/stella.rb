# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.469 / @SHA_*@ placeholders below with
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
  version "0.9.469"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.469/stella-0.9.469-aarch64-apple-darwin.tar.gz"
      sha256 "a65890f041e93fb93e46dbd609fecc7a53b75e0d27cc1f62d19f063477312d85"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.469/stella-0.9.469-x86_64-apple-darwin.tar.gz"
      sha256 "c942ac3ead66ffd91fd875d7caacd36af0284d0589c33fff13e95a9148b06a45"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.469/stella-0.9.469-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3184be928b6d40f0aba29c8ba59f40ca744824d2efa7b51bccf11303d9fdba94"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.469/stella-0.9.469-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "89daed99847863495436e2ceff0a5f04eef346d4ce28b869d6d256d049fa8ed8"
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
