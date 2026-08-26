# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.230 / @SHA_*@ placeholders below with
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
  version "0.9.230"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.230/stella-0.9.230-aarch64-apple-darwin.tar.gz"
      sha256 "fe1534a9e5b7f180f08953b294c5b4449f7d1a8f185f159f984c5b6cd0ba30f6"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.230/stella-0.9.230-x86_64-apple-darwin.tar.gz"
      sha256 "f183d48dfea93357ef2800e7ffe14a4ef1e97fdcf2194c91197d2b9d626e012e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.230/stella-0.9.230-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8902fbdabdc9c46efb6bc282a8ea95e0a8d918e006dfea0c3337deb8b6f374ff"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.230/stella-0.9.230-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "69c443cda57354f0f39ab3c6cdb980eb7169b71f876ff96e7de3662524a740d8"
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
