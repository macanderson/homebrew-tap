# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.45 / @SHA_*@ placeholders below with
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
  version "0.5.45"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.45/stella-0.5.45-aarch64-apple-darwin.tar.gz"
      sha256 "cadd0f9c7d7971dc3e28cf3b430de9b0e1909c99d4452d9404be0de7478bf786"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.45/stella-0.5.45-x86_64-apple-darwin.tar.gz"
      sha256 "928a76ae6424ee9a610964d59e161f5f67f1a85c7908291f7d483d7621f1582c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.45/stella-0.5.45-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1ef365652e9bb25058089a7139bc4dcb645238f4932c838f306bb1b4807aa90c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.45/stella-0.5.45-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "06a8cb70bbfc02da53919d9c29ebe0ccbbef5e3470b4fb2e948bf34b97ea310c"
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
