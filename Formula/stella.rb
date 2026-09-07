# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.400 / @SHA_*@ placeholders below with
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
  version "0.9.400"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.400/stella-0.9.400-aarch64-apple-darwin.tar.gz"
      sha256 "d1337f2143e20a61e03c72d47fad2d782834a014b2bf6659a9870abd069537a0"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.400/stella-0.9.400-x86_64-apple-darwin.tar.gz"
      sha256 "7ab1d0e7365a0804f96ec146daf16cf6b5ff4b120cafca8c2b33a70dc492fe75"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.400/stella-0.9.400-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b06adf7f8077bd821717e6f34908c2cfa769a8f02545e782347bb8346df5db01"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.400/stella-0.9.400-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "681d92e1cb9523afb056cfa0f5a180ac0e0c6f841bf53fb99ae560f431104a86"
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
