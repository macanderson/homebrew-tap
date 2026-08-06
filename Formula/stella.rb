# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.128 / @SHA_*@ placeholders below with
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
  version "0.6.128"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.128/stella-0.6.128-aarch64-apple-darwin.tar.gz"
      sha256 "45a2786b50aa59fdab87dc0508dc6b3ddeeaea356e4bca41a1d4feb132dc49a4"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.128/stella-0.6.128-x86_64-apple-darwin.tar.gz"
      sha256 "a350dd92717d1258d980d910fc7fb8e15d046ba56449d425fa0dff4e3fab168a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.128/stella-0.6.128-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fb3b590ab4cb02edba2216a7061db3fb2271bca9cf59bb76dae27849339e7fe1"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.128/stella-0.6.128-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1dc193f830765370f99f33ad0e05d717b0ced2ee8d4af11cfb482c665cc47f95"
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
