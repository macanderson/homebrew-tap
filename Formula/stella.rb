# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.355 / @SHA_*@ placeholders below with
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
  version "0.9.355"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.355/stella-0.9.355-aarch64-apple-darwin.tar.gz"
      sha256 "523a9b078d65453ea5fd0cfac41b6e78eff705770a0ef395670bb6a8787843ee"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.355/stella-0.9.355-x86_64-apple-darwin.tar.gz"
      sha256 "51cdd745978a88c238749d12129246ba5adfe6537b9368db0bd0a4075bf724c3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.355/stella-0.9.355-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fa8d9e7d8e2b20a817031410330aa4a7fef10add81baf0f37c3fd4dd80fa8040"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.355/stella-0.9.355-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "bbe90d6f6fdf09ba38d00c7d223355497573b4702580e930145b5e5f6f45174b"
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
