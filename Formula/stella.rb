# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.472 / @SHA_*@ placeholders below with
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
  version "0.9.472"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.472/stella-0.9.472-aarch64-apple-darwin.tar.gz"
      sha256 "076b2f8785c73b6d04bc12b592be26a8ce011cf5773dccfbfb072e7aecbad772"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.472/stella-0.9.472-x86_64-apple-darwin.tar.gz"
      sha256 "97b9caaa9aac5891b1c7b06b718c81dd4f12cd3a1298cd212c18c3ca093aa57c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.472/stella-0.9.472-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1183019de45dc4b2219d15bc6a8773542311f3d397918ed0316fdd8aed3fe608"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.472/stella-0.9.472-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6a4f779c89d970b6855ca663f6168ad4aafc97c5062f2ee443bb25852dd45d43"
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
