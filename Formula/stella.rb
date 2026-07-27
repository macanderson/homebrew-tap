# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.57 / @SHA_*@ placeholders below with
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
  version "0.5.57"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.57/stella-0.5.57-aarch64-apple-darwin.tar.gz"
      sha256 "191cf1e25d7b305e0c2459ef7af8ae9447bb5365e5324eb842a55e80029b790d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.57/stella-0.5.57-x86_64-apple-darwin.tar.gz"
      sha256 "83b3064b053301fbb4abfb45ded6ed4e9e412c0ce027374968836c338b97eb05"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.57/stella-0.5.57-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d1e45296819fbbda5231ef769deba9586d78924b835be773c71eaf2eafe909ea"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.57/stella-0.5.57-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "43e65f4d422757771c6ce7dcf7f1816b8429524674e8605e6c9cca3a25ddd01e"
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
