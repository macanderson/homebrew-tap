# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.8.6 / @SHA_*@ placeholders below with
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
  version "0.8.6"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.6/stella-0.8.6-aarch64-apple-darwin.tar.gz"
      sha256 "3479f835d41a30620fbab13c0c49d45991d9bc25eb7aa0f119733dcd5ec9edc1"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.6/stella-0.8.6-x86_64-apple-darwin.tar.gz"
      sha256 "fe0728c21b1ff66bed13fc19d8aa92403fb73e5ff497d6983b497089206d669a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.6/stella-0.8.6-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8b91ca7f4368962bce1c123ddfbe715c59668ef902599e17dae1ec6543779ee3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.6/stella-0.8.6-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c52bc9fbd054e7bd32119734f75829f48aa038f5e7658376d74034eee655a2b6"
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
