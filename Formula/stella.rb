# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.18 / @SHA_*@ placeholders below with
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
  version "0.9.18"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.18/stella-0.9.18-aarch64-apple-darwin.tar.gz"
      sha256 "d0f0ba5cb18755e893d3abd1be41e1ffcca1cdcd42e34342892b22d56e36ae0e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.18/stella-0.9.18-x86_64-apple-darwin.tar.gz"
      sha256 "9f9cc33c4dddd5a4a8210855d5829d8b5c0a91a8ffaddf5b32daa46f4ba2a9c0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.18/stella-0.9.18-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "62124045102f44d8902ee5e68fe4e6582d647f4cbd62f85ff0c62f2f8be9b9aa"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.18/stella-0.9.18-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b96354e196deb93450e75ebce025c429942a64a296c3eae20f6db7c8baebc561"
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
