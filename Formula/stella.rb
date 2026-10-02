# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.459 / @SHA_*@ placeholders below with
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
  version "0.9.459"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.459/stella-0.9.459-aarch64-apple-darwin.tar.gz"
      sha256 "9b38abdc598126453385401a530a866f60dbb88a699cdf66f3662ed79f03439f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.459/stella-0.9.459-x86_64-apple-darwin.tar.gz"
      sha256 "2d353dfbc74cce03681514874f142ba6994eefa4dc36952a67c0025c16187d57"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.459/stella-0.9.459-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9db422d5e5a0aa0b338c4af94afc46a2875bade1dd2c5b2c1d94549b47991c52"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.459/stella-0.9.459-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "00e7bd3aeda48cd90cf4df3f5e1578f2533e5098b184f023dc4d01330f652f90"
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
