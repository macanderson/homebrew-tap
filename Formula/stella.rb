# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.71 / @SHA_*@ placeholders below with
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
  version "0.9.71"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.71/stella-0.9.71-aarch64-apple-darwin.tar.gz"
      sha256 "b84be344d9b9603fa035a300534f4f2c05a4042989317f436248a0658e7827b2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.71/stella-0.9.71-x86_64-apple-darwin.tar.gz"
      sha256 "3b9e68791e39a9d3ee839dccae6332db30870621e456e664e7c4ed7d956ef781"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.71/stella-0.9.71-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f0e8456af70d1aa9d3b1f76f70d450ff2f8728c401bde8423e0b1a0ee514712d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.71/stella-0.9.71-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "70a712878d365c64417b7cd2d15dfa3f49cacae9df30b0411cb14a23642db61c"
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
