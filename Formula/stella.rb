# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.202 / @SHA_*@ placeholders below with
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
  version "0.9.202"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.202/stella-0.9.202-aarch64-apple-darwin.tar.gz"
      sha256 "76d0739af4b3aff9e73043760c678a513a073cca75b77bdf927d5faead5aebf8"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.202/stella-0.9.202-x86_64-apple-darwin.tar.gz"
      sha256 "c3e2fe15a50c5f8d76b5afbadbc91a93bdde2d3d86cf4aa3f618590a470021f9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.202/stella-0.9.202-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6dd2aca72e321c152535da70f58fc6b31dc25b389d5a4b0d0ce1d8e1e121f7fc"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.202/stella-0.9.202-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "347bb327efefd92b7902403e29b43ef9355cb76ba63a2615bfa778f78172131b"
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
