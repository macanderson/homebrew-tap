# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.68 / @SHA_*@ placeholders below with
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
  version "0.9.68"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.68/stella-0.9.68-aarch64-apple-darwin.tar.gz"
      sha256 "a8e6429199b4622271b46e1f89e0cfae49154d13b04d49611e3e17f4d6c76745"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.68/stella-0.9.68-x86_64-apple-darwin.tar.gz"
      sha256 "10ac083fbe07a8fb555dab8485c2a7f7840f56c56f703ba5b2263364701e02dc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.68/stella-0.9.68-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "34bbe0a843687867b08955ea527b4ee5a137f5119ab1700f95f14491e03f108c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.68/stella-0.9.68-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "954167cf865b5759a721e80000f559cfa9b048db0d6cd888acfbe5555f8943f3"
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
