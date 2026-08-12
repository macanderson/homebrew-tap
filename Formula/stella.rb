# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.4 / @SHA_*@ placeholders below with
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
  version "0.9.4"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.4/stella-0.9.4-aarch64-apple-darwin.tar.gz"
      sha256 "31a68254fecc2b9d14f6d7c2900166807ed808fadcf60d8adf06d2fbab4cfd6d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.4/stella-0.9.4-x86_64-apple-darwin.tar.gz"
      sha256 "728d0c7b71abf375be1b6fcb61e329da268db6d8a8f30afc14673da6e09504cb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.4/stella-0.9.4-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2694c05092a00fe1a8901f90f918cce5141d7f568a874a3afa7f8c7e366fcc68"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.4/stella-0.9.4-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6c098bde34e33e0b8b2b293add31f1ad5fbc6956079d0cb97e34eaca953eceed"
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
