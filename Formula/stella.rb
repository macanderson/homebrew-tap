# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.137 / @SHA_*@ placeholders below with
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
  version "0.9.137"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.137/stella-0.9.137-aarch64-apple-darwin.tar.gz"
      sha256 "453053243bab3ec8447c36b8ca9358c8e508c16273ec8d5e35fb8bfc363a149a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.137/stella-0.9.137-x86_64-apple-darwin.tar.gz"
      sha256 "fcfa42e0ee00cc12ce51eba8062e42dff3b7bb7f75e3bfcf8a3c43d791146a69"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.137/stella-0.9.137-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "645470002b3dee0c5c074212bc70baebdd1c13a0f07e38eb1db90c5df5d5f717"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.137/stella-0.9.137-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d2513167e102b69ced1ba2f26169d0abeae6ae31225c339dc2f7985402af92b0"
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
