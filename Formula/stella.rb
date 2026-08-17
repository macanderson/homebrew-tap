# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.63 / @SHA_*@ placeholders below with
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
  version "0.9.63"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.63/stella-0.9.63-aarch64-apple-darwin.tar.gz"
      sha256 "6fbef95ef05a3e3201180a4329761021e2ec8bb26ac79c103fb7fee228d4153f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.63/stella-0.9.63-x86_64-apple-darwin.tar.gz"
      sha256 "40c40904d11b90dec739bf5701c7cc86d9662fa0e15d60ed46fb42efe28d0863"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.63/stella-0.9.63-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0754eadbe9701b75306c6975b116145f1662436d1753bfec7b21c71c389d45e6"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.63/stella-0.9.63-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f129c5849cd86a8d94ae21642c39638d54abebc7db7fd006d1a31930fa6911dd"
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
