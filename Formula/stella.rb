# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.7.12 / @SHA_*@ placeholders below with
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
  version "0.7.12"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.12/stella-0.7.12-aarch64-apple-darwin.tar.gz"
      sha256 "201275b34bd38e80f6644e725e1bcdefcb0e4419956431e1b1ece27b709d6747"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.12/stella-0.7.12-x86_64-apple-darwin.tar.gz"
      sha256 "85c41c746e86a0eb79fafe5d887d40774bc8d86a9db74356df35f07dc6e86805"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.12/stella-0.7.12-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b19b70a1728bf22f05ff3f97adac9cd4bd225740ab3b3f98f959947826e78995"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.12/stella-0.7.12-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1dc473a71283435d60af379a12db48e75d78bd174b9c849c8fbbfe6a8e041f12"
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
