# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.109 / @SHA_*@ placeholders below with
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
  version "0.9.109"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.109/stella-0.9.109-aarch64-apple-darwin.tar.gz"
      sha256 "1a7f061840ee250fc5071a86e5c194abce805c230da84f08b8316389c2c4f273"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.109/stella-0.9.109-x86_64-apple-darwin.tar.gz"
      sha256 "648164029c4286bd4339965fb67c4f63d42f8cfa3be7ad34141416f24db0c519"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.109/stella-0.9.109-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "af37aa7242942e36ac7adc04a18193961d15c0244bb59a84c2ed8dc2ef0f3709"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.109/stella-0.9.109-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "66237fbff98925b5c655327e84bf85e308306266e02c1d3d8358da053d6681ec"
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
