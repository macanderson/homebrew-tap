# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.132 / @SHA_*@ placeholders below with
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
  version "0.6.132"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.132/stella-0.6.132-aarch64-apple-darwin.tar.gz"
      sha256 "39f2152a9363871f21f8bab788588b87a1916fcb1eadc075d2f194ff9f65f616"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.132/stella-0.6.132-x86_64-apple-darwin.tar.gz"
      sha256 "8f82d3d9eaaaf12f87d494badd883b2302fb82b0efa15359a481be3e928b4747"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.132/stella-0.6.132-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b00655da7f691cb73d28c66eac3b4bbf5cf149e841a65df61356c1c1bd768f65"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.132/stella-0.6.132-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "24202071aac53c9833bb0a29d7006fba5e0f156e1c180e96593878657f5609a4"
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
