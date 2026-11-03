# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.508 / @SHA_*@ placeholders below with
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
  version "0.9.508"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.508/stella-0.9.508-aarch64-apple-darwin.tar.gz"
      sha256 "946efce3110104a876e1905b2a365be7d9914dcbf0f030412e88aedda66dd22f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.508/stella-0.9.508-x86_64-apple-darwin.tar.gz"
      sha256 "ec5ef0a48717e78f01246fd0fe15070d96df75ac626b397a7802cef648c7d116"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.508/stella-0.9.508-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "dc573b3e42c8d97d056439da77319bdf31a9e721b7f98e1b864cef184d3ef92f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.508/stella-0.9.508-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c883919767121a98bea3a0cfc2f4bdfd6484987b8567b557a78150c8661d6c99"
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
