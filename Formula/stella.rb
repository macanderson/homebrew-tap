# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.8.31 / @SHA_*@ placeholders below with
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
  version "0.8.31"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.31/stella-0.8.31-aarch64-apple-darwin.tar.gz"
      sha256 "b84c012eb0b476f2388708c99d549a289514fef45f9d5bef46ffcfb1be0bdde2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.31/stella-0.8.31-x86_64-apple-darwin.tar.gz"
      sha256 "659165614e956c4176581065a380e1662904c5377a2b406a4217ec5c015fb76d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.31/stella-0.8.31-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8ccea6308f5669550f13f7b8f217774947259efb3c51633836f9172ff521f733"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.31/stella-0.8.31-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4dce2acb0df4f6f1fa7749a1c7a7d4dd77542c2eeaec889f6ac931bf1af1164a"
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
