# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.372 / @SHA_*@ placeholders below with
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
  version "0.9.372"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.372/stella-0.9.372-aarch64-apple-darwin.tar.gz"
      sha256 "7cfa8e37a62d5574e03db3cffd78e6fcb81ca6f687f45b0f513cc934ec9665a3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.372/stella-0.9.372-x86_64-apple-darwin.tar.gz"
      sha256 "38fa710442d5a28bbeda6fe536ec3e915fb59f182e0b36e84ba595172a07da79"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.372/stella-0.9.372-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "007d566d12c3ce3f59f8545343dd6ae75500296df64e5cfefe6be4df6aa3a25c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.372/stella-0.9.372-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f8d52f4b96b60a7394a126499e66c0a61268f00b518038ce9ffe28fddb056304"
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
