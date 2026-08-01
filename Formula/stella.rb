# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.40 / @SHA_*@ placeholders below with
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
  version "0.6.40"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.40/stella-0.6.40-aarch64-apple-darwin.tar.gz"
      sha256 "c8cc93dbd74e2fed5bfb4eedfae34812722333fbf7a2fe51197e316b837b884a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.40/stella-0.6.40-x86_64-apple-darwin.tar.gz"
      sha256 "94589a3bd54fc785925ce17ec7eb288cb29e47f5e76b53201b0c970c47bca951"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.40/stella-0.6.40-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3ec89eaffdf82c7dfa23ac8fc88a5ea39b129c81b9832e80ff28ea4669bcf00a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.40/stella-0.6.40-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2f7453c6fc911efe7bc7ce1d83ea0dcaa6a8d430f5edc774ed951880dfb5e734"
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
