# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.7.13 / @SHA_*@ placeholders below with
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
  version "0.7.13"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.13/stella-0.7.13-aarch64-apple-darwin.tar.gz"
      sha256 "7457e503c4d9e248acbc436d478b72c8c056ca3750fdb95677edcb51a345388d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.13/stella-0.7.13-x86_64-apple-darwin.tar.gz"
      sha256 "b5f9720c0973f84fa5a2096695ae41e1e6a0a5c639296fd4341ec5c06d3e6d40"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.13/stella-0.7.13-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c680eff2e7828c1127fd189a8cdffbb702bc258635709165c08b1aaeee469711"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.13/stella-0.7.13-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "312d741ecb639c58b9b4ebb059b70b2a41a3f7bb87837fa09d4f5de122118127"
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
