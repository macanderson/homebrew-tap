# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.109 / @SHA_*@ placeholders below with
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
  version "0.6.109"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.109/stella-0.6.109-aarch64-apple-darwin.tar.gz"
      sha256 "2de42da50622f3033fa4a973b638435e468f094af8d17f6ce65587297ec3a71e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.109/stella-0.6.109-x86_64-apple-darwin.tar.gz"
      sha256 "3e5360a0724caf39849e048450e9d4f5ab8db5bc40f066c84f883756ef6e9c10"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.109/stella-0.6.109-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "458ee2e6b73935093c71140ad08083d17b47d52ae3fc02c02552539b1baf2521"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.109/stella-0.6.109-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e8e08fc5b7e448448f44825fe926f0e762ee87f1d25eb4e7bf984ef89cfe83c6"
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
