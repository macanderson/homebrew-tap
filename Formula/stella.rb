# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.258 / @SHA_*@ placeholders below with
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
  version "0.9.258"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.258/stella-0.9.258-aarch64-apple-darwin.tar.gz"
      sha256 "d9f577fd97493e1ac24cd5a2204849adca68376929848f4da651cd62da9e73f4"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.258/stella-0.9.258-x86_64-apple-darwin.tar.gz"
      sha256 "3b9b95d6da6fc69c69a84cd7f9c21743829e425b54541f41f2ce6558327255a8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.258/stella-0.9.258-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f80042cce9b25dbbbbaea031aba83a56f42ed6f6fc2cea7b6054ed1391c32807"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.258/stella-0.9.258-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "dac8c1d8410d9d611d80c6fc208e54ff94a47844e20cda5aa9a8070f71df6754"
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
