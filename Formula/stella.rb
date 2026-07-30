# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.17 / @SHA_*@ placeholders below with
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
  version "0.6.17"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.17/stella-0.6.17-aarch64-apple-darwin.tar.gz"
      sha256 "c3e8e9ac13a3cfc019ff87b63df15e320820407e691f4fc7d5ceef0049ff3cfc"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.17/stella-0.6.17-x86_64-apple-darwin.tar.gz"
      sha256 "b5015926396fc5b7a47bda89c4cd718c1abd1b4ab8d7528b6ac4803292b0eb8e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.17/stella-0.6.17-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "cd75642a82e4934237ab0df84d10faea9e14f51c8622a37c6c6450d21eb047a4"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.17/stella-0.6.17-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "42bab97ff2bbebf4fe6db05b91eacbef8c55aa25613670d558f04d7041b7ddcc"
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
