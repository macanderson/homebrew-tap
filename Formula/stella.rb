# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.8.8 / @SHA_*@ placeholders below with
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
  version "0.8.8"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.8/stella-0.8.8-aarch64-apple-darwin.tar.gz"
      sha256 "821a89d86e844eebfe6fda4f2ee1298f913b392157ca016097a5b4fe05ded39f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.8/stella-0.8.8-x86_64-apple-darwin.tar.gz"
      sha256 "5baa3f641820eb09691da7fb7e654a5f9b63a6fec58244d03907e4f58140fb74"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.8/stella-0.8.8-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b1e5a41250029c6380164626eeaa785e3dbc231d374334f11f7b2360ee489878"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.8/stella-0.8.8-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fe6f2893b7416f89209cc52c3871b8836b8ee1051314fffbd5dd9327e4817f83"
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
