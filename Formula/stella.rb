# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.8.18 / @SHA_*@ placeholders below with
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
  version "0.8.18"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.18/stella-0.8.18-aarch64-apple-darwin.tar.gz"
      sha256 "5ee06e1864b209596fe6375e677654054eea7fa3b5963b0cde7f4067ec54040f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.18/stella-0.8.18-x86_64-apple-darwin.tar.gz"
      sha256 "b8df1b6ba83e7f8828efa8f14a26ba1a60305c4db125508bf79a8b0a8fdcbde5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.18/stella-0.8.18-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "596573d59e0c9d01be2cf5395b0d6252edcda3b0a6a397edfbffe7aa4b243250"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.18/stella-0.8.18-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f22ae43e91c9bd3b446c79ac58eb55d8e41cfec4cdf3208d2641fbeb64eb0b6b"
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
