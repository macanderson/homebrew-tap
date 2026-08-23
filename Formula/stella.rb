# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.162 / @SHA_*@ placeholders below with
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
  version "0.9.162"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.162/stella-0.9.162-aarch64-apple-darwin.tar.gz"
      sha256 "7c4f93b6f2705c626a881394eb9dd32d987c27c7e72be52d5c45bd62bf4add07"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.162/stella-0.9.162-x86_64-apple-darwin.tar.gz"
      sha256 "d34ad10fe5ad27bd243fcb1602ef385ff875ecb50d1f61b66f16c3a9e7cebdd9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.162/stella-0.9.162-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5f7ca368c653a132925b3a355fd61d128cc2472ba7e37187dd802bf427bed51a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.162/stella-0.9.162-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ac687d506d1d7ecb571024dc78baa28124c689093a3ff9342ab505a236da1925"
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
