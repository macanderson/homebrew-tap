# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.75 / @SHA_*@ placeholders below with
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
  version "0.9.75"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.75/stella-0.9.75-aarch64-apple-darwin.tar.gz"
      sha256 "14062000875809b57e594737646217729efcd1f670512868432f1a49155d88b2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.75/stella-0.9.75-x86_64-apple-darwin.tar.gz"
      sha256 "7f0b3ab1928b645e263f558be2e7ed148f04e4ccbbf74a2a0474285a23c275ba"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.75/stella-0.9.75-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7e6ef87476010e25674704e2488a990cc96b28dd3dec61b61afc6bd7caf9219d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.75/stella-0.9.75-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "89b366a94b56661d3b8974df70a06d24b9a9e10fc681cb0d03bea48d8a0a5880"
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
