# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.56 / @SHA_*@ placeholders below with
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
  version "0.5.56"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.56/stella-0.5.56-aarch64-apple-darwin.tar.gz"
      sha256 "5ea029da7ccc3d48860ae7316afb59bbcf7c7212624ec443777955f9a5219723"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.56/stella-0.5.56-x86_64-apple-darwin.tar.gz"
      sha256 "b0e2fc6f63c5f5eb6726a94cbf6993d1844f17734f6afe07d73090f7eb1abe72"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.56/stella-0.5.56-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "38b191595550de4838428c7148507a46505f19cdfaf3a87480bf098166aeabad"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.56/stella-0.5.56-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "552ba999d7835c2f14a80d89288e80fae5060e12b2102f3b3cc589bab18cdd4e"
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
