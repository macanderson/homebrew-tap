# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.54 / @SHA_*@ placeholders below with
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
  version "0.9.54"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.54/stella-0.9.54-aarch64-apple-darwin.tar.gz"
      sha256 "d34014a041f039b0098c206577556d2f795f33f9f39612e64c78a1d07ef1e7dd"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.54/stella-0.9.54-x86_64-apple-darwin.tar.gz"
      sha256 "22b14f323d7bcac038ffa4d776c2e1d36039f27cdcc5fc8598e5da11e5c730db"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.54/stella-0.9.54-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "bd0609c9485522b77b5ab651b4e2e474544e161549bed17398ff9bdbe538d4c6"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.54/stella-0.9.54-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d661e5b56cc48abaa14a7ea5817e5344eabbdb18a354fbe29307ded2c6abe7a6"
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
