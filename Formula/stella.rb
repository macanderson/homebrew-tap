# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.36 / @SHA_*@ placeholders below with
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
  version "0.5.36"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.36/stella-0.5.36-aarch64-apple-darwin.tar.gz"
      sha256 "cc2d86a80138c9aabcfe441cfb67f200f7b4438da7c4e7be6faa271baf4a16ba"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.36/stella-0.5.36-x86_64-apple-darwin.tar.gz"
      sha256 "c1fe3a299f53bc3d7f71fc221457443a076c93b055e870cfcbbe95453a64dda5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.36/stella-0.5.36-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "84849b7fb2a3586e6c3ee42f4760c7182780e55755c8813f50c8115c96aac3af"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.36/stella-0.5.36-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2f263d4485c20256b02ece2aca29b6e7f7177b31e6249e8a8e09b1534a60b446"
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
