# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.8.17 / @SHA_*@ placeholders below with
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
  version "0.8.17"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.17/stella-0.8.17-aarch64-apple-darwin.tar.gz"
      sha256 "00853e3242b3e8558ce2b951b7e924ba1f01f7671a4b4c09e05cca11c51ca8ad"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.17/stella-0.8.17-x86_64-apple-darwin.tar.gz"
      sha256 "aff9157fa2042a8aaee639360699a8cb3b97b2f9e817c45b091c580ff295aea9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.17/stella-0.8.17-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ff0fba7a3157f66a2bc011f5ab0731afd087a559214ed62d0420cd38d33503da"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.17/stella-0.8.17-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c8fe5a4e43b5e7a1959e44411bcc63d40e4e8562215b77bf5758d57c01b8c6f1"
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
