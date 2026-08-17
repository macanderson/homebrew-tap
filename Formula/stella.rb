# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.72 / @SHA_*@ placeholders below with
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
  version "0.9.72"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.72/stella-0.9.72-aarch64-apple-darwin.tar.gz"
      sha256 "1de452161a6acaf0813339e07630ed14a20fd577fe2e61626c3d7746e1b54b8d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.72/stella-0.9.72-x86_64-apple-darwin.tar.gz"
      sha256 "bc61dfbbcaf047360775128097cb5d4b06d4feff96d258bc1dad0fcd1428ad64"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.72/stella-0.9.72-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "56f1729d9a2647474d63b4504fc6f0af12de2646dc7b4b34d4c975e96abea86a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.72/stella-0.9.72-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "937c8cdc2fbdaa2bdd5edb641c6258017a1d14e654e0159eb26bcf3551e699a1"
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
