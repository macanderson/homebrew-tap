# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.179 / @SHA_*@ placeholders below with
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
  version "0.9.179"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.179/stella-0.9.179-aarch64-apple-darwin.tar.gz"
      sha256 "b62ed7694710b4f83a76e41714be863374acbdff894dc5ffaec1468c4c840ada"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.179/stella-0.9.179-x86_64-apple-darwin.tar.gz"
      sha256 "a0cf20262c8ce4d32b658485f6e158e433e19b367a2a80a876c70b72934dda8a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.179/stella-0.9.179-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d48c7e62baaf3fb19089ec80a2be7abd95da784e746d8477b4a2745a2e482454"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.179/stella-0.9.179-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "505a566a53d0af2649b5edd2c329ee514aa74ef99f94c9fcb5fd9283deb581e7"
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
