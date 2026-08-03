# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.72 / @SHA_*@ placeholders below with
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
  version "0.6.72"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.72/stella-0.6.72-aarch64-apple-darwin.tar.gz"
      sha256 "d59fd5385f05c9a0b9644a0b711d2bd5f213b14ba321b69d981b571b2e188972"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.72/stella-0.6.72-x86_64-apple-darwin.tar.gz"
      sha256 "53be8974b575907807ac49c109ea13b84e30df442856f81ec1e7310f39186f0e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.72/stella-0.6.72-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "06c0b2657ff59a376ee67555841a57d0533e6c77214840bb4887cb655e43f400"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.72/stella-0.6.72-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "71034df8786a278119529bc2e02a299e87906b9a70b48a0c7037184db411ab60"
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
