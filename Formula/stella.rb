# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.430 / @SHA_*@ placeholders below with
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
  version "0.9.430"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.430/stella-0.9.430-aarch64-apple-darwin.tar.gz"
      sha256 "694c2124d11288fdf232c5fc70af1c669e266b9b0a06687034a6edab9218dc3c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.430/stella-0.9.430-x86_64-apple-darwin.tar.gz"
      sha256 "9442e7f3872caba6db3a086c56e362b07c19cb020e2bf0b84fa83d9242fde12f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.430/stella-0.9.430-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "569313bcb3d1515ae3875e2bcfc447770255e2d90d4adfe28947322800e7b5cf"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.430/stella-0.9.430-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2eea3e1148712910ef28c4493903ce205d7b23a951a36469db003f59427ef40b"
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
