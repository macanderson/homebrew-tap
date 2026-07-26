# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.44 / @SHA_*@ placeholders below with
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
  version "0.5.44"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.44/stella-0.5.44-aarch64-apple-darwin.tar.gz"
      sha256 "cc007a0760d2f251f516e329c9133184bfe4af6f5371b87fe4e7b4c5d6e0bf21"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.44/stella-0.5.44-x86_64-apple-darwin.tar.gz"
      sha256 "58efbf1fca8d9b25c01175c9be2e03ab9e37a774fc363de18d480f1b0689ee0b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.44/stella-0.5.44-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0285316a2cbdd910f812390ca1295871a9192bd42413baf9f1276dc0c15cf2ee"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.44/stella-0.5.44-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "88062fbcd80abacab7b3e12efe84f07ec6202138de58f55ca9218c207b446640"
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
