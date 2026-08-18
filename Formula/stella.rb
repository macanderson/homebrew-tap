# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.88 / @SHA_*@ placeholders below with
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
  version "0.9.88"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.88/stella-0.9.88-aarch64-apple-darwin.tar.gz"
      sha256 "3036723ec0b42b622897a5468f881fd9c197610ac04461d5d4cf0943aed35bfa"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.88/stella-0.9.88-x86_64-apple-darwin.tar.gz"
      sha256 "c2141fba2e5e581f4d8a79ad3da1b4ed91e4f7b1999e3b7bfe6b1743e9b6e567"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.88/stella-0.9.88-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "39e387a7c30ceb256d30a6cc425364c0ae6cb9f9f171e604fac42abf74c06a2b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.88/stella-0.9.88-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c5f66ec9fcbd66f49ef508b7acdff45e92bf11ba522f534ebb4f23dd490b83ee"
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
