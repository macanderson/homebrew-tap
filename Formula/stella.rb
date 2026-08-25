# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.218 / @SHA_*@ placeholders below with
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
  version "0.9.218"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.218/stella-0.9.218-aarch64-apple-darwin.tar.gz"
      sha256 "b0620665caac3b59d11c98c2988003a3212f5b645c1202f6d98b37b4259afbb9"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.218/stella-0.9.218-x86_64-apple-darwin.tar.gz"
      sha256 "e19d28d0aa3dc433be6063ac68f70bcb3bf4ac8055714189d9ec34e43bb87da4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.218/stella-0.9.218-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4e35d9ab53ba2cfa9998540d8d2b02c9aceba2fffdfabbbf570e1fba0a369764"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.218/stella-0.9.218-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "17706ef88115648414429281c6ada0af141e957390435b0e0299d0aee68fb611"
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
