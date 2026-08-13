# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.21 / @SHA_*@ placeholders below with
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
  version "0.9.21"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.21/stella-0.9.21-aarch64-apple-darwin.tar.gz"
      sha256 "59dc945cdd13c0afe68b4f2550ac67e78b17d9adb610c38f32fc760774133cec"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.21/stella-0.9.21-x86_64-apple-darwin.tar.gz"
      sha256 "085f57a6fdcf7efc96e2c4d618096a55ebf6f5d37e0c7a10de3c1351a4fa356e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.21/stella-0.9.21-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "929c270ae3ac7c913f5ba308b742ef81c1b4d3f85bc3e52701939a7b6cc3f375"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.21/stella-0.9.21-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "dd52574712227d51a31c32879e3cf6c831db97f9a041f14fe976073a6fd15560"
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
