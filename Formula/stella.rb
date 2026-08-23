# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.153 / @SHA_*@ placeholders below with
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
  version "0.9.153"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.153/stella-0.9.153-aarch64-apple-darwin.tar.gz"
      sha256 "e1da846fdabdb296ed644c359674bf68e810a237465f5ae2ac8bbbbe484d9f02"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.153/stella-0.9.153-x86_64-apple-darwin.tar.gz"
      sha256 "17f6026404e1421f1f896276ece8b5474487ca6bc207db925afb9f7932d04eca"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.153/stella-0.9.153-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "067bb8bd7e73552b787b606242953e5c9c97458d386a033aaadf73440b82a76f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.153/stella-0.9.153-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3ffba9cb83add620502c01ee2f2f130c5b34a0b90e76481b337254e852034dbe"
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
