# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.371 / @SHA_*@ placeholders below with
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
  version "0.9.371"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.371/stella-0.9.371-aarch64-apple-darwin.tar.gz"
      sha256 "71ef5ad17c916ab94862975ccb6be242ae25af9bcd8e3785156c6b0eb94564f1"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.371/stella-0.9.371-x86_64-apple-darwin.tar.gz"
      sha256 "47bbde3d1b83b791d70ed1c10d280a4a977b901c16713b244cbf2ae94cf34ec7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.371/stella-0.9.371-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "cc35dc611b8aea09debee42181e89f690fc1719b66e93746ef01ec7681fae2b4"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.371/stella-0.9.371-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "23676c1d6179ae6f57ec882a84b4914ddcd4661c87d2f749d332854481032b1d"
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
