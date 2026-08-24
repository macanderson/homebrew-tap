# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.177 / @SHA_*@ placeholders below with
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
  version "0.9.177"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.177/stella-0.9.177-aarch64-apple-darwin.tar.gz"
      sha256 "9885d0dfa5ff84203d57413d4049a97dc058071e09aa85d5a8223150d2da977c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.177/stella-0.9.177-x86_64-apple-darwin.tar.gz"
      sha256 "fc6acb6d73dd54f969978067bae08874274a7ef565e5b3072d3c71e8b6ca018d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.177/stella-0.9.177-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ee77eff2d3b627a4d8c8a173c539da2ad94021fdb84c1a54f28e2a92bae42684"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.177/stella-0.9.177-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9241e8745e86c2f48b553ad69e99ae1904712eec92f49fbdedd800700757292a"
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
