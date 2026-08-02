# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.64 / @SHA_*@ placeholders below with
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
  version "0.6.64"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.64/stella-0.6.64-aarch64-apple-darwin.tar.gz"
      sha256 "2b675ca08f45f41f61fb101be1bb9d9de601378a7cf4a37c144a048115fb3253"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.64/stella-0.6.64-x86_64-apple-darwin.tar.gz"
      sha256 "d3c03cca3d64722db08383484e3d93059c4aae0e89850fed73a6b0c81256627c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.64/stella-0.6.64-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f64cedef9e3966643fafede66aa86d3c4cfea923be19ea5924cdb0a4a9a2ee32"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.64/stella-0.6.64-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "063256b36a5f6836194a045c967881d96b70eece70a4bd0bbe4e7921d203a01f"
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
