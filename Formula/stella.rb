# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.74 / @SHA_*@ placeholders below with
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
  version "0.5.74"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.74/stella-0.5.74-aarch64-apple-darwin.tar.gz"
      sha256 "5ef85477492fe666217195e11d98ffbbf517db2eb076164d1027fefb3f49440f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.74/stella-0.5.74-x86_64-apple-darwin.tar.gz"
      sha256 "0b0ae714bdcc8a65da46d858d078a2f105e1cdea6f2343f2a558cd2bea3a57df"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.74/stella-0.5.74-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0a8483a5c615d7f8cb9837fc65f8c1a0d6c542a4308124408d6513bd2794fc3f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.74/stella-0.5.74-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4aa8f8c6195af7795b568920cb2c411caa18a0bd9b9be72a7f78f62cb92dc68b"
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
