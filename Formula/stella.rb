# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.4 / @SHA_*@ placeholders below with
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
  version "0.6.4"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.4/stella-0.6.4-aarch64-apple-darwin.tar.gz"
      sha256 "09b4d4d9c4777d85ce1738feb7c8d39f7c12a9917e701f5bc78240a3ce9f68d7"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.4/stella-0.6.4-x86_64-apple-darwin.tar.gz"
      sha256 "09019488c786931e5889b3713cc45bd1b631fdcc05d69c489d399ac442b3c087"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.4/stella-0.6.4-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "14ffab0ab150f4354c5e44ef39aa9cd8f0b32d7edc34d57f3a9d065d01c549ce"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.4/stella-0.6.4-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d2126a88eab798d6b1764e9abc48d7269450fa724bbd18278e9d5e7a03d2078a"
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
