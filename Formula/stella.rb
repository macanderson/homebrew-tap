# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.377 / @SHA_*@ placeholders below with
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
  version "0.9.377"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.377/stella-0.9.377-aarch64-apple-darwin.tar.gz"
      sha256 "7c7d9335a5f139d4549e2771d68768fee8ae164d9dfcd07941dcab189ff1f1d7"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.377/stella-0.9.377-x86_64-apple-darwin.tar.gz"
      sha256 "086638bd39a9373e9f5056201ca2a8f9a0e42cef8d29bbeddb5f97eea33446bb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.377/stella-0.9.377-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "cfda41d4fe7b4d655677568a984378aeee8e5ca2043d197f367745695e88ae8b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.377/stella-0.9.377-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4bac65c3050563d6181fdf249bf8e1ba3d1988db3bf41a294fbcc00e6184d815"
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
