# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.115 / @SHA_*@ placeholders below with
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
  version "0.9.115"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.115/stella-0.9.115-aarch64-apple-darwin.tar.gz"
      sha256 "1046c9f5827bc6c5062a2d986971c622e95a089dc29e2c8dedfcf168b72eabfb"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.115/stella-0.9.115-x86_64-apple-darwin.tar.gz"
      sha256 "15690e26b11dbafc335112266597df2d872e25f970eb778b6a540460c01a8e62"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.115/stella-0.9.115-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8911f88cc01948faea539baf388b36ab5946eb2a2da00bbf2b869b68b2e873d2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.115/stella-0.9.115-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a6158c11f7a76248f41bd78aa96ea656af40ba6728a22e6ed415b2536c182667"
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
