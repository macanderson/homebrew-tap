# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.49 / @SHA_*@ placeholders below with
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
  version "0.9.49"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.49/stella-0.9.49-aarch64-apple-darwin.tar.gz"
      sha256 "e5ebf3c14f2d10134abdc40483c229c4181ca7291a3c4fbd6387af221461c81a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.49/stella-0.9.49-x86_64-apple-darwin.tar.gz"
      sha256 "351510e90e6ad98728dc320daaa155de1534997655c54c29f5c5a7e2a355dc36"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.49/stella-0.9.49-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f62c7f34b447e86e6c00ee42ff7d619873e0284af41257500791fdff228aa67c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.49/stella-0.9.49-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9bb4165e27f9814c2b623915096e2aa1f14f7790b9d5e79581bd451a5264a1b7"
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
