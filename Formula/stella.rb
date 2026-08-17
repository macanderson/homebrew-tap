# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.61 / @SHA_*@ placeholders below with
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
  version "0.9.61"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.61/stella-0.9.61-aarch64-apple-darwin.tar.gz"
      sha256 "271633713e2f2097a4aafd139738ffe1722c2e90b5cb2ed35e7c161dd5ef57f1"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.61/stella-0.9.61-x86_64-apple-darwin.tar.gz"
      sha256 "1011a4689f49422c282af1eb5e3719dea5a3441ac9439a7a9e0c7d4b135ae750"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.61/stella-0.9.61-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "23e08f232fe8420f15991daaa71c0c4b7c5c4e936099d19300cc65b117d47a16"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.61/stella-0.9.61-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b7083544faced326fabe701a26089de53b27ab5290b710af3ca04a6b07e5ef42"
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
