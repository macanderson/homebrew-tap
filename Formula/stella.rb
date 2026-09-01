# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.304 / @SHA_*@ placeholders below with
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
  version "0.9.304"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.304/stella-0.9.304-aarch64-apple-darwin.tar.gz"
      sha256 "da9a5cdddf8a6402651e44cfd85711680d2a002dac8b5d5ed4eb92c4713596e1"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.304/stella-0.9.304-x86_64-apple-darwin.tar.gz"
      sha256 "844d7f3807ff5177674e16f6aa7ca3f1ba8e1275fa7e88b4660ff68478048d0b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.304/stella-0.9.304-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f18effc106a57545ba60a072e6f209126a2086148ebfa83575318414ba452f53"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.304/stella-0.9.304-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "57b10a323eecd09f9c4e39317e8cf66428389532b76e67e218dbb2be456e2f50"
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
