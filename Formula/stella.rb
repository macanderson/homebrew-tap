# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.7.9 / @SHA_*@ placeholders below with
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
  version "0.7.9"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.9/stella-0.7.9-aarch64-apple-darwin.tar.gz"
      sha256 "27efc2d676ba44cfdc10031b6e4b1629c357c03ba779afad7e7903bdf76a8f17"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.9/stella-0.7.9-x86_64-apple-darwin.tar.gz"
      sha256 "3893f82a512f01ad0c67948d2d070b2e5f5f402be1abb822232dc81dac7d7040"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.9/stella-0.7.9-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "04a3d853f751615654596521ee5a22a1fceb7e424d49a25961e27223e669e27f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.9/stella-0.7.9-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "bdc8b07a13f75a63bf6279b1b8eaf88ee69302fc1748992f4500b81a89d2d6b1"
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
