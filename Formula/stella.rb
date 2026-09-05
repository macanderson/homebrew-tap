# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.331 / @SHA_*@ placeholders below with
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
  version "0.9.331"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.331/stella-0.9.331-aarch64-apple-darwin.tar.gz"
      sha256 "73f65bb3a81212aecb46e947f09a99d585b1cf022d5465cc60ee4487964a94a9"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.331/stella-0.9.331-x86_64-apple-darwin.tar.gz"
      sha256 "f3f3ade64a65c40e66af590f119150162ca3578aa0f89afe988fe847efe10e50"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.331/stella-0.9.331-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "328fe8bdc295c90faaf8d526c04ff1775b9b092801a91f0cfdce0c69ff88f86d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.331/stella-0.9.331-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b765c2986e85df7b739e74ee8f40a121b98bab71ba949c8c27a2e11bd6a5e30e"
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
