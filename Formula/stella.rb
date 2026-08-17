# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.66 / @SHA_*@ placeholders below with
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
  version "0.9.66"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.66/stella-0.9.66-aarch64-apple-darwin.tar.gz"
      sha256 "62e2ed05ff05960b1f53832df45344a39e1d3e703578c3de19c52842ef756485"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.66/stella-0.9.66-x86_64-apple-darwin.tar.gz"
      sha256 "a760b074fb2b94ba166873e096b528c4759c04ad7f40ec8f17849f7d30f86570"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.66/stella-0.9.66-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4822b93dc2156d75c5024da0f9fb4c58f20e893b05822cd094ee4274d4c641d5"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.66/stella-0.9.66-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ac689fa91c5eeadc302cf1681f9a6ed3ccc0d22dd394c01800b60770f7a61ca1"
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
