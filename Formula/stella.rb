# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.71 / @SHA_*@ placeholders below with
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
  version "0.6.71"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.71/stella-0.6.71-aarch64-apple-darwin.tar.gz"
      sha256 "28187d1bdfa9dde93464a13af6b0a8faaa9af9e3986757c66b3ec0cc68f98b37"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.71/stella-0.6.71-x86_64-apple-darwin.tar.gz"
      sha256 "98f129a3929540319d64daba828ba632299a3a2169313df293dc59a16cfc241e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.71/stella-0.6.71-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1f9d64d3082e2b0ef88546105bcf87f8631b168db59f8f008c648ec0ec88f3b0"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.71/stella-0.6.71-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4e9b176922455e5859570778f86bcea4a0547e9ec448807446de87ad135bb720"
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
