# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.69 / @SHA_*@ placeholders below with
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
  version "0.5.69"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.69/stella-0.5.69-aarch64-apple-darwin.tar.gz"
      sha256 "1276f992864596b65d6a971afe2abc3bfe18082a4cea4ba550cf3bb13e45896d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.69/stella-0.5.69-x86_64-apple-darwin.tar.gz"
      sha256 "4c4cecdbb50a398a340ce7d86d536de9d3e0340daa37e26f154349126b6ba19e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.69/stella-0.5.69-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "191527e5a16557f1a7c5910dd8c39693a4b1b74c58d38e652b91e705f07d8bb1"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.69/stella-0.5.69-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "aaa78fb8bbf794a0d978a644a65f2baef5d6d263ecb439fd582fea6cadd99ed4"
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
