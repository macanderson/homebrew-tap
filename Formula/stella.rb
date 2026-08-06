# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.118 / @SHA_*@ placeholders below with
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
  version "0.6.118"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.118/stella-0.6.118-aarch64-apple-darwin.tar.gz"
      sha256 "5a5e8cb651c290b6d8310a8137505aa8702d15d5591e75adffbb328e49882cb4"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.118/stella-0.6.118-x86_64-apple-darwin.tar.gz"
      sha256 "7676a941fd096281a9faf26c26cfb84128025382901b6fe16f364e60350b0b51"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.118/stella-0.6.118-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "632ad49773377d9f47f3d57deeab8a07a0c1b579558f0eadd659cdfac0b0e503"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.118/stella-0.6.118-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "db34469a8c183266f7462f99355ae229cf1eaaa7d3a7fbeefad000050f9ba430"
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
