# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.77 / @SHA_*@ placeholders below with
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
  version "0.5.77"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.77/stella-0.5.77-aarch64-apple-darwin.tar.gz"
      sha256 "f52c848168dcaccd81fc5a4cbfe0531b0b5d0ebf719ee374e532b8481db882cf"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.77/stella-0.5.77-x86_64-apple-darwin.tar.gz"
      sha256 "bd5c5015ff4f47aee495128f4052bc39c6f428e0eacd1e7152c0e07f6f5060e9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.77/stella-0.5.77-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d59ddf6b9923dbaec3f52feb0b4ae86afbbd08c32792ee4cc419b5fad2f9cb3d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.77/stella-0.5.77-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0ee95ce5615aac49c1fb126af82a39e1d360eaa741debb706a629bdec1acdc5a"
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
