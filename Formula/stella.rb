# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.14 / @SHA_*@ placeholders below with
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
  version "0.6.14"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.14/stella-0.6.14-aarch64-apple-darwin.tar.gz"
      sha256 "4fb92c3a29a8eeea503e5d9b902b43a246f8ea16da8b7f4bb59c83e8f9fd6fb8"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.14/stella-0.6.14-x86_64-apple-darwin.tar.gz"
      sha256 "bfa2c8f3c537a420d2b5e94a37172c360012d5023ee83a4e1eafcb43ae31d12f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.14/stella-0.6.14-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ec72f94912240e27623d349fbce852234a44cb67f64ba273b8fd2e3c4cedb93c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.14/stella-0.6.14-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ae34d00dbe3b3f67193067d1ec7c09664cca12d38952b9a27c44bf9d20f1d69e"
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
