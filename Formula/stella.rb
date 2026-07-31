# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.27 / @SHA_*@ placeholders below with
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
  version "0.6.27"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.27/stella-0.6.27-aarch64-apple-darwin.tar.gz"
      sha256 "55972f0ba1e27f286cc51d7762f96537d13a0ea6ebd5704b95a7874b49662549"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.27/stella-0.6.27-x86_64-apple-darwin.tar.gz"
      sha256 "8955ec77347c8f2c77ad8043cf628c5d84fa3160d5997c6565d1c5dcd8fa7930"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.27/stella-0.6.27-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a3371228238c9c3fcf878d17801127c30fbe4a4b8051f1c744125873c6df5a2d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.27/stella-0.6.27-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "943101d65d3f7b1f31a06fd735551058535de333b4e8bcb60f40b294de09d9d0"
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
