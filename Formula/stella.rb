# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.471 / @SHA_*@ placeholders below with
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
  version "0.9.471"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.471/stella-0.9.471-aarch64-apple-darwin.tar.gz"
      sha256 "0b743b9fa84299c0a44c2f8144b8df45424f097c5bc4684cf0ff9207d8e57caf"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.471/stella-0.9.471-x86_64-apple-darwin.tar.gz"
      sha256 "147d353cab60ae9c0b19b091e709fd5f8f20953aaff292eaa36e57ce9177ce51"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.471/stella-0.9.471-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "35812f878b5ebec559ed86bc9e114a556ad9444c40ab409af38e296716fd3e37"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.471/stella-0.9.471-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b0a00a8553fa3c722ef20d27675ac3bf33eeec152c11d564ae7942c1a7165081"
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
