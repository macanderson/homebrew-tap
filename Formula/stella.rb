# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.30 / @SHA_*@ placeholders below with
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
  version "0.9.30"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.30/stella-0.9.30-aarch64-apple-darwin.tar.gz"
      sha256 "dcafeae8183557db509b8c333a84ef778a5d3f02ad9e79b842c89621b4423af9"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.30/stella-0.9.30-x86_64-apple-darwin.tar.gz"
      sha256 "73659967db7cfd66c182e9f3171e08598d13187a166ebdfcd8030a76a447f263"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.30/stella-0.9.30-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ebd378edaf3d2b5a64ea61753318ab663d018c74eec0d6c6384f72daa7093397"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.30/stella-0.9.30-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "979a303227eff2bb3379ffb1e9238eee94066fdf50a2933d75ccb5611d4a5218"
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
