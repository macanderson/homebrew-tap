# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.243 / @SHA_*@ placeholders below with
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
  version "0.9.243"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.243/stella-0.9.243-aarch64-apple-darwin.tar.gz"
      sha256 "2f2c67ba9931d52d835c35c073bc8d4cf479755951f8d2ca9b1c066bb4c85c71"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.243/stella-0.9.243-x86_64-apple-darwin.tar.gz"
      sha256 "86e7f3a93de30ef59e6ed904ce0c96d5fa664a078792eb0b61a567fb66ce444c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.243/stella-0.9.243-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3659f6e42583a0f80504baf1cda580cf55a443d1d3ba4b659caf245339b76cc2"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.243/stella-0.9.243-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2ce5dae56a832f9802af321e95c5cc99ff26fd13f15c215617df71b2b01287db"
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
