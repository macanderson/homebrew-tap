# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.122 / @SHA_*@ placeholders below with
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
  version "0.9.122"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.122/stella-0.9.122-aarch64-apple-darwin.tar.gz"
      sha256 "ce1b65b8efd900f6e3950b5bf77f280a7f5111cd30e94cd50278a054faed20ba"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.122/stella-0.9.122-x86_64-apple-darwin.tar.gz"
      sha256 "790205f0677eb949792ae4a44a8764e378a0342c8ae511a46459b5076bf532c7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.122/stella-0.9.122-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d69e560500200938eaa7e9d294b5ed90632c039f642490d2ece662ddd9bca8a2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.122/stella-0.9.122-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "eb0c85f43749e4612b6a3a1e0a73f954be1e089469b81bea1b6c79a7d229ef44"
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
