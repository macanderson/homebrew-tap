# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.20 / @SHA_*@ placeholders below with
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
  version "0.5.20"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.20/stella-0.5.20-aarch64-apple-darwin.tar.gz"
      sha256 "26572efad2d7405c23635218c76ad07b6a1afe5c99a4eff363f2187f9be5aeeb"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.20/stella-0.5.20-x86_64-apple-darwin.tar.gz"
      sha256 "971b908be0f63dbf8db6da651e6ad55ccc019facbfd38060ec9a15cf747ebc0a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.20/stella-0.5.20-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "89c46c82de8ccedaa9063f33b55c44be6fcab2f498aa64427dce969c3a5abc3e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.20/stella-0.5.20-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "021a08733461fad8406eba26f4dbece37d02bd1f2a9265c87f29613d4eac7aa0"
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
