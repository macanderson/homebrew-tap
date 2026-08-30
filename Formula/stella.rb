# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.288 / @SHA_*@ placeholders below with
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
  version "0.9.288"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.288/stella-0.9.288-aarch64-apple-darwin.tar.gz"
      sha256 "d08f2429917e397292acb001e336ae37d4451a18bbf0fa59116c48561c126382"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.288/stella-0.9.288-x86_64-apple-darwin.tar.gz"
      sha256 "1db8daec94ae34c5b1128d5cf314162acf148d69ebfd0531e45ab1ef6f9e621c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.288/stella-0.9.288-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1ff6b5a034d8626abee7235318b645a74b9caf9174e64f7fe055b3bb92c8f218"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.288/stella-0.9.288-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "86155791b45c916e2c6602dd0e27c962484ceb26e3acf6e6d70f502a5e77e6fc"
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
