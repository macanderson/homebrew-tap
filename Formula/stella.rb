# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.206 / @SHA_*@ placeholders below with
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
  version "0.9.206"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.206/stella-0.9.206-aarch64-apple-darwin.tar.gz"
      sha256 "d0e33ef10cfd6ee0382181056598df90b4839e966fd245b34811602c74efb423"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.206/stella-0.9.206-x86_64-apple-darwin.tar.gz"
      sha256 "fd7c03b00a121b4a50eb6038d57d4ad211654f1c9c7e0116eaddbde1e416f04b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.206/stella-0.9.206-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0d108d07d806b3353839387001492da28505cb33cb60cf4269dc7b407a860082"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.206/stella-0.9.206-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2b0dfdfd68bbd70aac259edd62c13dad9807e5ac3775976699d5859d02639144"
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
