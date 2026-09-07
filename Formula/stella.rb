# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.395 / @SHA_*@ placeholders below with
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
  version "0.9.395"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.395/stella-0.9.395-aarch64-apple-darwin.tar.gz"
      sha256 "7b22223fc1f695a2491cf73e251d687648ecd7505661b0524c970ac84b8c41f9"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.395/stella-0.9.395-x86_64-apple-darwin.tar.gz"
      sha256 "b1cb3ad32dde0d834eed9951a9be330f3b3b12e4f90834c5d1e43532d6a8faf4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.395/stella-0.9.395-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3add62320c82d8798fa360300398cd03ec7583911712824b093bb6bfd210886c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.395/stella-0.9.395-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "545247096ca6be877e2b0ec9c2ae70d72c3a2168ea58c7749c3e88e2f7f97c6e"
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
