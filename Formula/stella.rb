# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.119 / @SHA_*@ placeholders below with
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
  version "0.6.119"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.119/stella-0.6.119-aarch64-apple-darwin.tar.gz"
      sha256 "36c22ae2e11726d45983dd4961cec1c5dd855840117cafe83ee1e28a2c541432"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.119/stella-0.6.119-x86_64-apple-darwin.tar.gz"
      sha256 "3b44577fe324642bd3d77e8ec8ebdcaa9f8bc1ebbbaf89998e9940561e5ad3ff"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.119/stella-0.6.119-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "dc3f1951b578075cea40197861bf272a997eb3487cdb022696874058fd04357f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.119/stella-0.6.119-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "998647a596e09e1bd7d6fe0c28f6cd3572f9fcaf633e6eae4284a66f6dd8fe0a"
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
