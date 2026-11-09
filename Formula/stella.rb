# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.519 / @SHA_*@ placeholders below with
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
  version "0.9.519"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.519/stella-0.9.519-aarch64-apple-darwin.tar.gz"
      sha256 "26c15b02eb9eca509792769c28792078852d3c741a1ab69c95d0c4ce05ec9da2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.519/stella-0.9.519-x86_64-apple-darwin.tar.gz"
      sha256 "53ce15882583ec0fafe889d0b99abfe8ac680c1255318e38300c95822f15c834"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.519/stella-0.9.519-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "143515780bf69c3886095281d437e458bcc5b586aaee43c247215a01e73fa02e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.519/stella-0.9.519-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2c11a1eeed3c4685daea73e9e623456f8a936d1c2a0a51fa4200c445fa392dfa"
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
