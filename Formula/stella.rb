# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.369 / @SHA_*@ placeholders below with
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
  version "0.9.369"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.369/stella-0.9.369-aarch64-apple-darwin.tar.gz"
      sha256 "431e0b28986f83e9d3d530438b720dd6a597838411c10cffa243f340e0c04f04"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.369/stella-0.9.369-x86_64-apple-darwin.tar.gz"
      sha256 "33e02bb13747cc156c23198b905a18f5040a1d7b4c661160de288aa98abd005c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.369/stella-0.9.369-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "aacfb2296e26e50623e0769451907315cf4dafbec5d42b053b18aaa832eadcf7"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.369/stella-0.9.369-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2ba734112080b787da4b42a95a8b2d6f4a5b62a39a918074bd8d7df891821ead"
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
