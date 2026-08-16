# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.48 / @SHA_*@ placeholders below with
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
  version "0.9.48"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.48/stella-0.9.48-aarch64-apple-darwin.tar.gz"
      sha256 "51ecb5b535889ecd8a014c63e07895fd2703f496ad71610de16c5aa8e36fa065"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.48/stella-0.9.48-x86_64-apple-darwin.tar.gz"
      sha256 "0a5ba468be9550865497c939a500c33854f3224cad4bff3e1327fb862bfb4b02"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.48/stella-0.9.48-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fe6afe5cf29eb19eecb47998a25c2783f28e354b204c6440339b9d780c7dc56f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.48/stella-0.9.48-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4ffc4ce0a93db284f939371371533954abf47cd27b0954d94ad02d8df3d7fe0a"
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
