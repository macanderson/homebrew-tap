# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.289 / @SHA_*@ placeholders below with
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
  version "0.9.289"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.289/stella-0.9.289-aarch64-apple-darwin.tar.gz"
      sha256 "9e54da1b0b0adf7c1a775c1f5134495d048eaf368492c4a27b5f3dace2032a04"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.289/stella-0.9.289-x86_64-apple-darwin.tar.gz"
      sha256 "1509f1cba47f042d29eb3b312aa24d3ef00e9017b35b8f05cf099779b88dbf0a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.289/stella-0.9.289-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "76b0735fd16c8604d343276b5fff92090cd0bd86ca73c693808ffa475152d58c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.289/stella-0.9.289-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "99d51469e878551be9c15692f090332828e1cef5454fc4aa8ca55c684defb090"
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
