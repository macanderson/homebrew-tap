# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.200 / @SHA_*@ placeholders below with
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
  version "0.9.200"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.200/stella-0.9.200-aarch64-apple-darwin.tar.gz"
      sha256 "eb8b7362c80ed345b96f5ea990480463c00ab264bb7af8d427f6f56917dba10d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.200/stella-0.9.200-x86_64-apple-darwin.tar.gz"
      sha256 "77a7de1e059be850f8c7106166a3d4198159116eb5ddf416aa185f25792e9642"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.200/stella-0.9.200-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1d0e46cb5e14159fae1e7b99e173d173a8713dd368f190d2e6208b2e4b009c32"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.200/stella-0.9.200-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "54ec44461a863360129d7f30024a9a99006eaa5e33441d15f426b6e14ed02b40"
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
