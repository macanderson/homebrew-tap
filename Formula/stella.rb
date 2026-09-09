# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.409 / @SHA_*@ placeholders below with
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
  version "0.9.409"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.409/stella-0.9.409-aarch64-apple-darwin.tar.gz"
      sha256 "29e41ced0c3a5ad7a4dd0440385690788bb72d5e2925b4be95ac8d920dc2ff92"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.409/stella-0.9.409-x86_64-apple-darwin.tar.gz"
      sha256 "9e360f8e34c67a67e14c4789b23b9a8c8df91768a88a004b9aea4ba1c7ba45db"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.409/stella-0.9.409-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "86e2b42091a0e838d58b6b9818a2a7fa18392e881de181291f2fb97eccb90d6e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.409/stella-0.9.409-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1228532ee7a4b9eab9c9f62da9226b0b578b5e2d45d5b80a129046b4b9c5036a"
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
