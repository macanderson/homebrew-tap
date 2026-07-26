# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.31 / @SHA_*@ placeholders below with
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
  version "0.5.31"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.31/stella-0.5.31-aarch64-apple-darwin.tar.gz"
      sha256 "b2dd2e395d38067e67b7253ef2d25e8e170bbf6ecf8dcad60ac1430eb7964d91"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.31/stella-0.5.31-x86_64-apple-darwin.tar.gz"
      sha256 "ce11fc37a34e7ac69805c47d3ba347ce77f931a7414ee7f819b2041cdee1d99e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.31/stella-0.5.31-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fc2d15e3eae1604b85d4feb8835ff02870f89b09f23cfdb32c16ed9388dac04d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.31/stella-0.5.31-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "95b85e5e67bfe36c0524a1fd0fc5468396041de0bec0b2fed19e99bbec99a215"
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
