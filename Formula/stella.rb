# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.379 / @SHA_*@ placeholders below with
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
  version "0.9.379"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.379/stella-0.9.379-aarch64-apple-darwin.tar.gz"
      sha256 "c1b97f13322a95866acfbde9d1e6967901fcfb01ea19fa16ac0cc1cb34c9d86b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.379/stella-0.9.379-x86_64-apple-darwin.tar.gz"
      sha256 "0a0f6e6e93944b3d1fd06679546d103d5c97aac106ff253a7b202a7eec18e721"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.379/stella-0.9.379-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6ec5386497ca13b3b47ae40aadc1d7c8612598494f5faf8e405b7892a8612969"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.379/stella-0.9.379-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "58bedea0bd9a905a4560f11f1def73404906e3fbf39c2ec910e0e19e315af7e9"
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
