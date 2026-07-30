# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.16 / @SHA_*@ placeholders below with
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
  version "0.6.16"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.16/stella-0.6.16-aarch64-apple-darwin.tar.gz"
      sha256 "8b62884be3ba5102b9a180a169dce743fb7f60a0e779fdf790e30a40d06c835e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.16/stella-0.6.16-x86_64-apple-darwin.tar.gz"
      sha256 "2988b00583697d20a0e10908c5754db0825bc9e990da9c462a6ccb82432b0760"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.16/stella-0.6.16-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b0079b146cb22541aa810f035bf4717b37c6ce2606e7d86caedfc937df37fa2f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.16/stella-0.6.16-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d5bee648de7f55cea3c7c705f6cd04a65ddef22cb8ab8aa6b5aa36ec28775871"
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
