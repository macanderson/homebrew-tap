# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.247 / @SHA_*@ placeholders below with
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
  version "0.9.247"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.247/stella-0.9.247-aarch64-apple-darwin.tar.gz"
      sha256 "51c9b2783069ded053b14fd395c8c9e9263e4e094c214c5f87801710171ac81c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.247/stella-0.9.247-x86_64-apple-darwin.tar.gz"
      sha256 "1e02f3a1c2e2613a23b116e58f1be1b4a681ff2de58856695b7b145ac19ecdf0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.247/stella-0.9.247-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0d28b040fde858533b3ab90029eeb89310933e838179ab69f62cd28601ce0fd7"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.247/stella-0.9.247-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4fdc8da7db0a7b4e025bbb5b6b8aef7ea4795d0602c3835193d7923ff8c73bb1"
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
