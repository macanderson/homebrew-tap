# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.253 / @SHA_*@ placeholders below with
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
  version "0.9.253"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.253/stella-0.9.253-aarch64-apple-darwin.tar.gz"
      sha256 "07fa5b2615ea81ae12935dab350fd4764df448146a29ee4ad8c98e324ed1b6b6"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.253/stella-0.9.253-x86_64-apple-darwin.tar.gz"
      sha256 "bcad1430697114390596f73c4424dabd3e5ba65579e6f5e13dcc5c39b6a17731"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.253/stella-0.9.253-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "03a03330d45ce205badd627611f068ede931d8fb3f89af5b5c272e503dd6af9e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.253/stella-0.9.253-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b40c3d3f08b3434988ab09185a0ce0f5bae75ef620467133088577edf147971b"
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
