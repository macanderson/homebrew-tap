# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.42 / @SHA_*@ placeholders below with
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
  version "0.5.42"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.42/stella-0.5.42-aarch64-apple-darwin.tar.gz"
      sha256 "e8c95dd120360d8fdf0a4249cf55a86aeda6f53967ac5adfc7b5f1bb6fc3e4f0"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.42/stella-0.5.42-x86_64-apple-darwin.tar.gz"
      sha256 "68a54aef4cdb9f172313d5a272838336833dae91baeb6309d2d3a308e86dcbe0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.42/stella-0.5.42-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ffc9a0f78b07f06263fb016459e73c14d8d057baee61654862eb78034c99b613"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.42/stella-0.5.42-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "72c417af5cd3a465dd34b0ae1933b418d5f3af15ac604bd225dbe1857dbafc35"
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
