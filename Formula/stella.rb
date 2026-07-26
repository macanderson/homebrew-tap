# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.29 / @SHA_*@ placeholders below with
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
  version "0.5.29"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.29/stella-0.5.29-aarch64-apple-darwin.tar.gz"
      sha256 "96e27f677c8f8484c8b6b8eed5ec2f55bdd689e0fb061c59b289cc3dfbf492b9"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.29/stella-0.5.29-x86_64-apple-darwin.tar.gz"
      sha256 "d48dc577ff82b3410a8bbb8a9b7cbfe0872c3b64dfb2fe92cf40d071f8088e55"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.29/stella-0.5.29-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3b0c900ebdf921f58112dd2349ab070e526ac9d0607872c5a14bbfc57a1fcf68"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.29/stella-0.5.29-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "72ca405aced38a6caf75d5a163f95a20eebcc73e6123fd12b8712d89955ddc10"
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
