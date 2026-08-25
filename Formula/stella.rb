# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.217 / @SHA_*@ placeholders below with
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
  version "0.9.217"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.217/stella-0.9.217-aarch64-apple-darwin.tar.gz"
      sha256 "313d1c703dd6d7e7ad52c40621bd4552d812606163550e053cf8ee44dc68d8f2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.217/stella-0.9.217-x86_64-apple-darwin.tar.gz"
      sha256 "fad8a1020e22bc5a5788fb3ee7c0ff19b51e2334d1b3ae28c06d7a031c45efe9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.217/stella-0.9.217-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "20e795ea71b29e07a6007b9a896f1c7a7395dac0f435f4ef81b264e78125bd0b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.217/stella-0.9.217-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ec8750b9316edb845763a0b573606eecb8cf225f470036d7a9f14cd8ec54e537"
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
