# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.97 / @SHA_*@ placeholders below with
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
  version "0.9.97"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.97/stella-0.9.97-aarch64-apple-darwin.tar.gz"
      sha256 "3807b1d92457b8bc78ed09f4c474fd030bf5e33ebea65373036951552da8b5c1"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.97/stella-0.9.97-x86_64-apple-darwin.tar.gz"
      sha256 "db943c42ee0eb0b2a8467f12804bbe933158bf87922da5a9a8c87532f727d2a5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.97/stella-0.9.97-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4bf3865f40da65814653a41cdc16ac22e5d4bc03be674d9b250d9cf72b8ffee6"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.97/stella-0.9.97-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2ef3c734e1c66103a57a6dc3f77272fb5620b0e985458178d6df01e204c3dedf"
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
