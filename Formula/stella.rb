# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.42 / @SHA_*@ placeholders below with
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
  version "0.9.42"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.42/stella-0.9.42-aarch64-apple-darwin.tar.gz"
      sha256 "9b24f35b1f2447eb551db6465e23898668b4d437e996f55efd78789b7484fa62"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.42/stella-0.9.42-x86_64-apple-darwin.tar.gz"
      sha256 "e6ab14c9d91029e91e8ae8e94d11a4918c5391dfa822998dded05177e3af0f61"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.42/stella-0.9.42-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7c30eff92dc710ec90bd6d5a41b5e914f51bf155a6981c02eff4b8772097999b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.42/stella-0.9.42-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d89437e724781afd68576c4ff073ae9147ec9c98e005a293036730d1c738cd27"
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
