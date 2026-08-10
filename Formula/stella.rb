# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.8.26 / @SHA_*@ placeholders below with
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
  version "0.8.26"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.26/stella-0.8.26-aarch64-apple-darwin.tar.gz"
      sha256 "d461dcdfae285655d8ecab0c973302877105c787e1f28d656fca778941e8ce6b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.26/stella-0.8.26-x86_64-apple-darwin.tar.gz"
      sha256 "104d62a7912ded6d0d9efc52eb9e78b9f3445f7794e551e7a0f14699881a5a1d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.26/stella-0.8.26-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "acf5687f25f57616bcda38bf6a524ee0807b33ef24b572abc6ec541cedc0a740"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.26/stella-0.8.26-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f2d429f1f69a1216be4c4d8b8b9886d98422c5785d607ec8128a07903fc8e879"
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
