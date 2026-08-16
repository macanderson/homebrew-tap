# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.52 / @SHA_*@ placeholders below with
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
  version "0.9.52"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.52/stella-0.9.52-aarch64-apple-darwin.tar.gz"
      sha256 "f1ee6f96feefcde6c18d464da14625f99261b0083225d5eede6482533d11796c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.52/stella-0.9.52-x86_64-apple-darwin.tar.gz"
      sha256 "6ec50d505ad4c2b85d7cf3d9109f12ad77b8f388e9f6d5104703feb198b1a6b5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.52/stella-0.9.52-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "301981c53ba7c377ebdb2ee67e5c438f27346efa48e5748cb9656338baf92f0c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.52/stella-0.9.52-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f8974982809e8819334dbc9f0be37e902f6c384b6a22f18a4d73b89114456a66"
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
