# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.118 / @SHA_*@ placeholders below with
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
  version "0.9.118"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.118/stella-0.9.118-aarch64-apple-darwin.tar.gz"
      sha256 "2d79fdc9c988c0d81fa47e684d33ce5808540d2087fc7097cc96d6f5fd15adfa"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.118/stella-0.9.118-x86_64-apple-darwin.tar.gz"
      sha256 "7a897ef9ad1ca9e8442ece10935d0df3f1fad44b27084be5708f70a0203c535c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.118/stella-0.9.118-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6f8601073de8a522dba0803bbfff0902df29c606956a08613e9d15d741e8189f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.118/stella-0.9.118-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6642d710273e89edcaa595ee4098c7ea0f27834f81882a3ddc86377d85d49d8d"
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
