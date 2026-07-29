# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.3 / @SHA_*@ placeholders below with
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
  version "0.6.3"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.3/stella-0.6.3-aarch64-apple-darwin.tar.gz"
      sha256 "94d8f097ffdee5c34cae3330f869781b4aa34166dbd438110166da7e36d94a4e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.3/stella-0.6.3-x86_64-apple-darwin.tar.gz"
      sha256 "01e078e0047755f30c4489ce7e4d083eef21b8884febe40868e95896a9598d89"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.3/stella-0.6.3-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9ccb49f99e4eeacd97339ed641e1b962ff0fd1fc5e231954449f051d8049df6c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.3/stella-0.6.3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0489c16191e63af10715e71369f218d0451097c0deddaa1442158e04d4d56b09"
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
