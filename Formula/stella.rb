# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.329 / @SHA_*@ placeholders below with
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
  version "0.9.329"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.329/stella-0.9.329-aarch64-apple-darwin.tar.gz"
      sha256 "0faacbc689eeaa9508c6244acbee750af65ef2e632d21d407d5eca8ea651134b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.329/stella-0.9.329-x86_64-apple-darwin.tar.gz"
      sha256 "8613cbedcf286c391faba70ba923980d45bd12ada81c34516f0edf357e2fd385"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.329/stella-0.9.329-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5a9570264b056be0caf8bc20d7520011e0174370be6a72b1ac594575464059ca"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.329/stella-0.9.329-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d70aaf7c8050cd5b442fefe3af64ed1a28d51c6a52d61af114421bf499bdca33"
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
