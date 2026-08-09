# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.8.11 / @SHA_*@ placeholders below with
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
  version "0.8.11"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.11/stella-0.8.11-aarch64-apple-darwin.tar.gz"
      sha256 "fb369e7af1825fc9b617d1197265955d3cd03604c0f7cc9eece506e515bfeb2c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.11/stella-0.8.11-x86_64-apple-darwin.tar.gz"
      sha256 "f7cd852dcc91b4b013fc894952fdcaa5a196f9bf61850fb432e7329d238520df"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.11/stella-0.8.11-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9ab1b1d461fc79881a0bc386796c7f7da7fac7dd53b2546f23e9f52641c2eba3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.11/stella-0.8.11-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5a40a6489bb53b7e42f56fa3b7db837f986c5cf9f3313d51a4df253813a1c79d"
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
