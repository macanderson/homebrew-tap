# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.112 / @SHA_*@ placeholders below with
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
  version "0.9.112"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.112/stella-0.9.112-aarch64-apple-darwin.tar.gz"
      sha256 "88f52957c951fa71a79d5fe728c2f61dd20fda343b8dff04d69bd869ad8226f6"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.112/stella-0.9.112-x86_64-apple-darwin.tar.gz"
      sha256 "bdfe7aa6d7ffb1a05b0a2b1f04f33e13f5b99882df03b09b2a7ea390b9b45494"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.112/stella-0.9.112-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "70ba9ae7eea7eaa3ed8df91fba23d299d34e339e3ff495e6ee0cb78a62b0d104"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.112/stella-0.9.112-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1320c62276d810a8db51184e572aa88bca22cedab5f336ae66efebd0b3bb72ab"
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
