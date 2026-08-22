# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.130 / @SHA_*@ placeholders below with
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
  version "0.9.130"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.130/stella-0.9.130-aarch64-apple-darwin.tar.gz"
      sha256 "ac976516f00ee28af440152ea91dbf0ad3d841ffec34b0c512cdd36bb3e8672c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.130/stella-0.9.130-x86_64-apple-darwin.tar.gz"
      sha256 "8f8367bc1e557a77ff3c33b48ea94bd1e9d7a705a82e45c4a590e98251d4dfbd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.130/stella-0.9.130-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "28e34468d8922bf8ed4c1b31f247bdefe6cc9d811b4af6d26477175deb5274fd"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.130/stella-0.9.130-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "86a1bee5bf75c091eaebd92ac7c476350a5141fb247e428de2d09d222c5d61c1"
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
