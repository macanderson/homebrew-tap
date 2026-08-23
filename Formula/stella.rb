# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.174 / @SHA_*@ placeholders below with
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
  version "0.9.174"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.174/stella-0.9.174-aarch64-apple-darwin.tar.gz"
      sha256 "d61c011fd946460f4c5a281377457bfcd36ddad851e48e5dfd65b5ec26e5899c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.174/stella-0.9.174-x86_64-apple-darwin.tar.gz"
      sha256 "a0da68ded5d05dd481f52b7c21599a3028089205662b13e432d81903ec2cb42c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.174/stella-0.9.174-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c33d3610d38ba68ccae6e2a8929b06166a11f6b9eb9a0580449e6ebed8629471"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.174/stella-0.9.174-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0478e4bd770f26d3fd73eb38627b1799d30a2bfcca0ed801928b56f0371706fb"
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
