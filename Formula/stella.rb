# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.463 / @SHA_*@ placeholders below with
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
  version "0.9.463"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.463/stella-0.9.463-aarch64-apple-darwin.tar.gz"
      sha256 "2e3cfee47c6a84a8160b7b3dc230d5aaf5968ea82fb857e255d0e2e70150d3d1"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.463/stella-0.9.463-x86_64-apple-darwin.tar.gz"
      sha256 "2b9f91d23fe303f195bbeb4644753007f1efa50fc690526d2c6d09e0df37f91f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.463/stella-0.9.463-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "40a4eafc76c817aa34ce312ed7ee7f25ea5b4b1c58044c22a378b309ce75de29"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.463/stella-0.9.463-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ed8310a8a35c74cce1731dd422135bb53a95c0e763b5d271887a9289e7eb1cc9"
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
