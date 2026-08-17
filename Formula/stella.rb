# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.81 / @SHA_*@ placeholders below with
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
  version "0.9.81"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.81/stella-0.9.81-aarch64-apple-darwin.tar.gz"
      sha256 "f1ced94d4d2dedab8b2007e3a7ce229e876c77d3afd468eb4af53f1dbfcf80c7"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.81/stella-0.9.81-x86_64-apple-darwin.tar.gz"
      sha256 "0bb7cb023fa31dcdf0a938681d46f3454708f930430520b0e9375ca550292345"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.81/stella-0.9.81-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "98b09dd44d34048ce10dd35cc1337b1fbfe8f50e0404bc7e2138bba4a50456b3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.81/stella-0.9.81-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "74a27a516861724c29e3017cc1bda3c9430899a394aeac4a4c635055ef7a9702"
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
