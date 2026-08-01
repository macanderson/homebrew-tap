# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.46 / @SHA_*@ placeholders below with
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
  version "0.6.46"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.46/stella-0.6.46-aarch64-apple-darwin.tar.gz"
      sha256 "3f9b80c0eb26e360882ee35e36c50e4206eea51d4a2b8e7e43405e01fdb49a25"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.46/stella-0.6.46-x86_64-apple-darwin.tar.gz"
      sha256 "0a6a06afbec46618cda3a569ada087aa84e872575c961cc646f69e1e27ea2a01"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.46/stella-0.6.46-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9e08671a7d00eda8dbf8d1c3341a65f50f57f1f0437ea8989f967a7a668584e7"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.46/stella-0.6.46-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1b187e6d9966d0318fac4c35f95d33bfe5d0572a3b91900645d1c41b7d6198fe"
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
