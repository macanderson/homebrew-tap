# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.298 / @SHA_*@ placeholders below with
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
  version "0.9.298"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.298/stella-0.9.298-aarch64-apple-darwin.tar.gz"
      sha256 "7ca589d81a9c6dd780e5105b3648688ed3ca42bc229aa3a5c0a9ddee769ff30a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.298/stella-0.9.298-x86_64-apple-darwin.tar.gz"
      sha256 "3cfd4642bdb70cca5540ebc75992637bd34ee87cae198e29348b8575527ede1c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.298/stella-0.9.298-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3df930b071bfa9e43dd8f5d304d6ec27f100873ac2184acc90d7d351bcea29c2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.298/stella-0.9.298-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1ac963c784627dd84fe142801abd05f64cb2724a378cc65be0e23c9787ed6756"
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
