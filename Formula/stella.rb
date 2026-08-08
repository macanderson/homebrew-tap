# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.7.31 / @SHA_*@ placeholders below with
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
  version "0.7.31"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.31/stella-0.7.31-aarch64-apple-darwin.tar.gz"
      sha256 "78be43f6539461404315c31cf77790e7c7bafebb620118ba5bde6100166398c8"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.31/stella-0.7.31-x86_64-apple-darwin.tar.gz"
      sha256 "5144ac2fb8b97f4846e1a4375cfee044a8ad716896b1f306ed6963e948c60ed4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.31/stella-0.7.31-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "15c77584c8b84915177379e9da2acb1b3578e9500132fd3660903d482150dd83"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.31/stella-0.7.31-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d4a9a3a7445c4e1c7838e7e5429c47cc04a1d583d7b05e924bba5318eaa83a31"
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
