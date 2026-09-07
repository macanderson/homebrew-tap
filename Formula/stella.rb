# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.397 / @SHA_*@ placeholders below with
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
  version "0.9.397"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.397/stella-0.9.397-aarch64-apple-darwin.tar.gz"
      sha256 "d41c7f01b27a9e33ae6f3850ac461c56a7966a410b7ee63f1aebb0fec11bf64f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.397/stella-0.9.397-x86_64-apple-darwin.tar.gz"
      sha256 "8be35d7d79861322d240775d7fa6c39c83c8155e9f7682d894b334dba0d6ea6b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.397/stella-0.9.397-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9ea25e2c20ac178bb14f6db9dd9eef7763fc910591d01baebe5fcc18ebd8d7a8"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.397/stella-0.9.397-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9f735711a075d223a27a8f020177f6f3959eed86fca0038a097af8f36ccf48ba"
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
