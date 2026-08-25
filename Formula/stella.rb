# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.213 / @SHA_*@ placeholders below with
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
  version "0.9.213"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.213/stella-0.9.213-aarch64-apple-darwin.tar.gz"
      sha256 "a058f06597dc8811bed7369701f94882b46073c7bdfa4c839d713f791245d907"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.213/stella-0.9.213-x86_64-apple-darwin.tar.gz"
      sha256 "e653f52f08a520e0760f029b15223f73db2ebdb6dc24eabc80cdbc0a43afe80a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.213/stella-0.9.213-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fd30327806999cbe803377e0de277780590e4dc389ad164b9f37921b1ac3cb38"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.213/stella-0.9.213-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "637ef63d4e36b559937624a3bf4010302b6a99b34012c1309e15cbcbc012e792"
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
