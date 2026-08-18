# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.89 / @SHA_*@ placeholders below with
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
  version "0.9.89"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.89/stella-0.9.89-aarch64-apple-darwin.tar.gz"
      sha256 "a96ab06812cde5078268a956add7ea479dcbd6d7c04a14ef40586869d8d788d1"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.89/stella-0.9.89-x86_64-apple-darwin.tar.gz"
      sha256 "bed45a8727c914b517bd0427479a5c81e754fcbbba027b5a96a30e348e6c5a5c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.89/stella-0.9.89-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7d2032bc8e66d2ad1393edc10f279de3d154558c7e7eb6d8c80989f236cc7377"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.89/stella-0.9.89-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d624de8af23ef5e3234a766ed478681aa9cb696907b50f71c02048086a46d554"
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
