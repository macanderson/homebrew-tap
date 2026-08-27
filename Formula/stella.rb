# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.266 / @SHA_*@ placeholders below with
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
  version "0.9.266"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.266/stella-0.9.266-aarch64-apple-darwin.tar.gz"
      sha256 "3dd9125e0c17f33b1159f9d187e480e74319b5ddd411ee10b522aa5db498dcdc"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.266/stella-0.9.266-x86_64-apple-darwin.tar.gz"
      sha256 "36b063355fc1f258e38d000d0c8e1188930015af98ec668143efc3250d2834a2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.266/stella-0.9.266-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "70324497502203de1f4a184a7b08d36b0bbbd4194038f45bc9618673759a0407"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.266/stella-0.9.266-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ffd0fa99a2604d803e4e4587d349f0ce10db064461feefc656b072b06f3d2809"
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
