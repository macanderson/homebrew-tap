# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.8.10 / @SHA_*@ placeholders below with
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
  version "0.8.10"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.10/stella-0.8.10-aarch64-apple-darwin.tar.gz"
      sha256 "05752b74229f56b720237cd950384b60373711504bfa5cf7d3761dca38e8066d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.10/stella-0.8.10-x86_64-apple-darwin.tar.gz"
      sha256 "f266278572b8765aac0ff1a58c76e8d034ea6856658571ef2a75f6a1db854dcd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.10/stella-0.8.10-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "dd1ad17d6f85df3f452c1f46990f80980134864278d9fd5134551b82d03d5f7b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.10/stella-0.8.10-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "98de10a338d6334e0e3d09f7c78b55d2ef563e6acd66b2ce22c5a03a4623e2a2"
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
