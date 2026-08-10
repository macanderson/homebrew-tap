# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.8.29 / @SHA_*@ placeholders below with
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
  version "0.8.29"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.29/stella-0.8.29-aarch64-apple-darwin.tar.gz"
      sha256 "64e710808360e15f47e71706bc7c80e548c6735e74621d580b2510ef14a08484"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.29/stella-0.8.29-x86_64-apple-darwin.tar.gz"
      sha256 "0694a66fcc0c7206e2ee5031f7544de023dad3785094cf1902ba8f0ffbb13dbe"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.29/stella-0.8.29-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "211477e812ea4cb28eea6c9d41bf08b5e661907489867bbda2f0d3b4a4240512"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.29/stella-0.8.29-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "856f2f9c97673bc88eb42e2e54fd6fbd80fa3ec3dc3e23a270a3aa59bfe08abf"
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
