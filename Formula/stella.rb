# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.190 / @SHA_*@ placeholders below with
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
  version "0.9.190"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.190/stella-0.9.190-aarch64-apple-darwin.tar.gz"
      sha256 "f0cebd15b552e794c00919403ee6dce5590d4e5a4c754be1b7dbcdbc40c83fa6"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.190/stella-0.9.190-x86_64-apple-darwin.tar.gz"
      sha256 "f1ee64c585ffffe6ec0221e8225cfc285b3337bfac0899cadbe0c5962d1d2553"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.190/stella-0.9.190-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "dfcf523f085aca8e3adfc851bd7a6f68607de92805de2f13b5680f881a19b454"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.190/stella-0.9.190-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "028312b665e4efe600063b234aa270ac1c061d543c2d7169c7ce14f271f19dc4"
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
