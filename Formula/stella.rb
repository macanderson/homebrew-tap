# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.448 / @SHA_*@ placeholders below with
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
  version "0.9.448"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.448/stella-0.9.448-aarch64-apple-darwin.tar.gz"
      sha256 "57ed8b055b4d5fe4ad65c10510aa473e0ba7aa240e2642a2a2debc1aae70a562"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.448/stella-0.9.448-x86_64-apple-darwin.tar.gz"
      sha256 "108be6e1eddf294b69e264d1e593b0f1a55fd62e89282d42b673d4e9fdc5adc3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.448/stella-0.9.448-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4c396ac624c711a5d55fda28ca01875851f8d6ca711978a9b39825fd1d4e22b9"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.448/stella-0.9.448-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0482cde42a9715b5df44fd9fc4d2f0c5e7038862d65aa6459846a86695b7ac99"
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
