# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.363 / @SHA_*@ placeholders below with
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
  version "0.9.363"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.363/stella-0.9.363-aarch64-apple-darwin.tar.gz"
      sha256 "1b9e5c93c0e0a3aeb5de4fb44493ee26ecf4199e3672e1718173905b846d4436"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.363/stella-0.9.363-x86_64-apple-darwin.tar.gz"
      sha256 "c53cdc5fd7d4545e594ae7ee704505da9bec298089fe61b3eee673f7910c7555"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.363/stella-0.9.363-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d5cfc98beee0d91d397406e0b3c800c24d9af879614c3701563cb7bd958b568f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.363/stella-0.9.363-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b6e5594b16f8154ffbbbfb2a8f897c51d34fc3458fdf1ca0c9a4bad1bf98f2b2"
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
