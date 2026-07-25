# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.28 / @SHA_*@ placeholders below with
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
  version "0.5.28"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.28/stella-0.5.28-aarch64-apple-darwin.tar.gz"
      sha256 "07185f8847454c51ddf50ac827e3445e6d8976990ebeb434825ba17537f2b612"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.28/stella-0.5.28-x86_64-apple-darwin.tar.gz"
      sha256 "ab89c9ec05fc09b8b278dd1508bc66871280fe9ef2abc0d7167842824f90bf32"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.28/stella-0.5.28-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "84acd0a7ed7ab6bd503becc17b45b8ba2836d3cd3cddfb3d7648c2d0eed01893"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.28/stella-0.5.28-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d428f7664f9c026fb648bcbc94c520d743c24d0ecf3165c4e1f962c40b0379cf"
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
