# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.7.35 / @SHA_*@ placeholders below with
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
  version "0.7.35"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.35/stella-0.7.35-aarch64-apple-darwin.tar.gz"
      sha256 "460213a7bf396f5833790b44ee8787e782acd20d0c1c1300ffe54cf8a4576297"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.35/stella-0.7.35-x86_64-apple-darwin.tar.gz"
      sha256 "5d04e38906755e9264fbaad666e8a7124bfb6e65e4ac795b3fe1c178c6f027f4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.35/stella-0.7.35-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6b7624728ce7841f23c018d43162c5af911e0608866f2da87336bfc556ecb9a3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.35/stella-0.7.35-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "26f8f0cc5da75e363399c262096b496b92a7c4dc6ff0ca7517455c36eb67496f"
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
