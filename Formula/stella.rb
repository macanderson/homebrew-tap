# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.18 / @SHA_*@ placeholders below with
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
  version "0.6.18"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.18/stella-0.6.18-aarch64-apple-darwin.tar.gz"
      sha256 "36ed862400f43c79c784ef3aad8db03fe321382f7bad1bb9d4555227b4eac9a8"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.18/stella-0.6.18-x86_64-apple-darwin.tar.gz"
      sha256 "c4a7275d32ae4ec55ccda2d07de47548617732c98a176c2ccb4ca9794eeeb4fa"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.18/stella-0.6.18-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "51edcc6987bd2a84913fd31232e0ed648452feadf857521a1745258cf78d4dee"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.18/stella-0.6.18-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "246b46a00508784e44289b502e8c54cb56450c66e6d1fdd08e2fc843c486c896"
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
