# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.316 / @SHA_*@ placeholders below with
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
  version "0.9.316"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.316/stella-0.9.316-aarch64-apple-darwin.tar.gz"
      sha256 "ef7c0c893b2630d6da82c4108d2f5e2e10da013d4e004caf050742d0015cc1c9"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.316/stella-0.9.316-x86_64-apple-darwin.tar.gz"
      sha256 "d670f441a0dfbab81d07950107efe3fdb0976d725756d58a66af9c680929b372"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.316/stella-0.9.316-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c25715ee0772a9f2b554e128ae98c5de000fcac2f63d52982e99f9a5c073267b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.316/stella-0.9.316-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a8eae0cf2e67fc0b2cdae78a1ecc9c15597819d8ab8c372ce4a46d5a8e9774db"
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
