# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.139 / @SHA_*@ placeholders below with
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
  version "0.9.139"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.139/stella-0.9.139-aarch64-apple-darwin.tar.gz"
      sha256 "4c1fb826907e9ea7530900a38ef63925a0527af31a16a2c1949c3df18eb89f56"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.139/stella-0.9.139-x86_64-apple-darwin.tar.gz"
      sha256 "b62678670c8ca90d4c1f143a6f96678c858183f767d325b2074e5fc1f2111349"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.139/stella-0.9.139-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1e55504948096057899505dc8198e52da2aa6dbb3d9fa0bdd4d82001275dc697"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.139/stella-0.9.139-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "85ec79f2a1e9cb6741478ab468e7ec538bc64d451195777ad8784e3fd23323ea"
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
