# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.6 / @SHA_*@ placeholders below with
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
  version "0.6.6"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.6/stella-0.6.6-aarch64-apple-darwin.tar.gz"
      sha256 "a30fbc789eccc33de5e6ac70e38a3d8f0486b418d55c95b772db2590a73f8144"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.6/stella-0.6.6-x86_64-apple-darwin.tar.gz"
      sha256 "46b027c8bbaf135bb71f3e30423ac61dc464b6e489e0002cdaededb4177a1fe1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.6/stella-0.6.6-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0a298a259f3f9c44a9bca1edd6ce19cb6f7e4bdef4bd6940d061286997f8d1d7"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.6/stella-0.6.6-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c55bbba8afb66bba23a536b9b48a24dec838146bab6b815edead725f2731fb27"
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
