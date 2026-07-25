# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.22 / @SHA_*@ placeholders below with
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
  version "0.5.22"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.22/stella-0.5.22-aarch64-apple-darwin.tar.gz"
      sha256 "a26b51e89cd6f37baa670bb84738e9955420acbf20f872fa8cae03cc9924fc38"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.22/stella-0.5.22-x86_64-apple-darwin.tar.gz"
      sha256 "90277e3b03de940ba8ca107dc029794379140ba596d148f68a55fa47304efa0b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.22/stella-0.5.22-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "527cf9cbc578d114a5e0519a0ad222c83deff1f957aaae3c20ea0f1acbc90147"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.22/stella-0.5.22-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c868609e37ca1aed81167b64b75f98c9fd1119661d22a63a5d290dcdab530797"
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
