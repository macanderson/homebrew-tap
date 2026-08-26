# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.228 / @SHA_*@ placeholders below with
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
  version "0.9.228"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.228/stella-0.9.228-aarch64-apple-darwin.tar.gz"
      sha256 "04bc2915216c6967b388149e865834ab43c54f0ffbcf424a827ba2e18e1e060c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.228/stella-0.9.228-x86_64-apple-darwin.tar.gz"
      sha256 "34fee2c332dce4160b498d423372e2854ab0eeb5f1ba9ee6b35d1af35935ab78"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.228/stella-0.9.228-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "72f2295c427e55149ade0bd9ee91fc91b70fca9bebe53806949a3aad3a420ede"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.228/stella-0.9.228-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6933d7bde520502eff7f18887fcdebc910400b08e3b7daf1cbcad49783680e92"
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
