# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.246 / @SHA_*@ placeholders below with
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
  version "0.9.246"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.246/stella-0.9.246-aarch64-apple-darwin.tar.gz"
      sha256 "c534fb664b9b4f11f08687c644b3914baca5a189d3ea0bb55b506a1ba7b14765"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.246/stella-0.9.246-x86_64-apple-darwin.tar.gz"
      sha256 "5f04fc7c1b08f7ccec699b8d803fc8a6b8aabce3db3687d96f000334a506fba6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.246/stella-0.9.246-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "55299e55d3831105e1da83bb3801fba6c7476855d69f44363d0d21cad0d19762"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.246/stella-0.9.246-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8b9cb3d63bf5f1e4eb754610dd685f723461c3281569f0c7e645be6f389a0693"
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
