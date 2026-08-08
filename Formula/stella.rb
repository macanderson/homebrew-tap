# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.7.25 / @SHA_*@ placeholders below with
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
  version "0.7.25"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.25/stella-0.7.25-aarch64-apple-darwin.tar.gz"
      sha256 "9ad4dc379d05380556cc840a98f58f9b935a170fdc63181365459969517de0c5"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.25/stella-0.7.25-x86_64-apple-darwin.tar.gz"
      sha256 "41cd9fc7d8ca03dbc98a1002f39a833ea7f818230108338867d171b23ab8f035"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.25/stella-0.7.25-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b4cb42467ec9c37f7894541b7337ef76a04a95e3458d9375fd601b825e022da0"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.25/stella-0.7.25-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6c1d86eb86fa9ec84aa401e14956a14713cb7cadaa8906d502fc5337ed4db3df"
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
