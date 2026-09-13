# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.423 / @SHA_*@ placeholders below with
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
  version "0.9.423"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.423/stella-0.9.423-aarch64-apple-darwin.tar.gz"
      sha256 "7c776d4f7d6afad58ea79efc1589f3448bc466770c7fb16ab9867bb95e43fd78"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.423/stella-0.9.423-x86_64-apple-darwin.tar.gz"
      sha256 "686dca182a294f2ca586ad57bf3e7af9cde728acecad200b03e89973dc2822f2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.423/stella-0.9.423-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c2bbbeab1d8ff486c8a4cf36e6988ad34baf2011c63aea2e065b82c18b5b2e90"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.423/stella-0.9.423-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4a0e97eea53c9c91747e90d0028bc50de853060810c5a2d945c1f752d2371bd8"
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
