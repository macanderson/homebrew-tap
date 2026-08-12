# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.16 / @SHA_*@ placeholders below with
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
  version "0.9.16"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.16/stella-0.9.16-aarch64-apple-darwin.tar.gz"
      sha256 "a755c83380c0dba25ee28899123ed60035c0eb8f176e37544eb2cf93e2c77e6a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.16/stella-0.9.16-x86_64-apple-darwin.tar.gz"
      sha256 "394d08bc5b611cf4ed33d0fac81fd2bf03f203c1fa8e5d15ed9599ac27c8a017"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.16/stella-0.9.16-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f154f84bc849d029d07ffdd10337615efb64363b7881c34dbc7d9ec9b0626398"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.16/stella-0.9.16-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8436af4dbfe3178d33936028d79b97ce800f3e02ab1b0cde2b5d8b99fa7c73d8"
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
