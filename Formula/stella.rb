# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.113 / @SHA_*@ placeholders below with
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
  version "0.9.113"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.113/stella-0.9.113-aarch64-apple-darwin.tar.gz"
      sha256 "3fe55f6df9b09cac3f5aeae016c0334388903c20560b24849db34fcf208827be"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.113/stella-0.9.113-x86_64-apple-darwin.tar.gz"
      sha256 "dd5b5c77e40a515e28d7d387d9dc92e24e11029f5f9b88cfb34ba59d1d73cf8a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.113/stella-0.9.113-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8a7812e221811ba58302dd16d6a981597500f1f844ec211fd3375a806cdf1cc4"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.113/stella-0.9.113-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "eba573fd06d7388dacd3f4cc30dc93797fc5b2b01d907371ac00b5aa3f7de8ff"
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
