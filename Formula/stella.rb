# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.8.7 / @SHA_*@ placeholders below with
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
  version "0.8.7"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.7/stella-0.8.7-aarch64-apple-darwin.tar.gz"
      sha256 "c04fca354aff7d8d9d90db998b9b5a58888ff909bf667b5a1cbaed70e826d331"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.7/stella-0.8.7-x86_64-apple-darwin.tar.gz"
      sha256 "7b77ab8f738f46f389e50c3e7917a9915a5b3bd22c18bcb9278a0e70b3da04ac"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.7/stella-0.8.7-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8828cdf82d7246bce89c477edf208676a38abc9f3a87acc78ded74cf5804030e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.7/stella-0.8.7-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1b46abd52397cddbbe505dfd741974f0733e9cabe6a7242e14bf255393b9bb31"
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
