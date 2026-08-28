# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.267 / @SHA_*@ placeholders below with
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
  version "0.9.267"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.267/stella-0.9.267-aarch64-apple-darwin.tar.gz"
      sha256 "ba3f6bc7671e25bdf08a4a6c82cae277ea5076c4afd00b1400fb49098f306616"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.267/stella-0.9.267-x86_64-apple-darwin.tar.gz"
      sha256 "0d5039b95c168b313fd1cffdcfcd174e595ac0ad16ec7756be964a221c3fcde4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.267/stella-0.9.267-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "80a93050b90cc722dfb6cf855f606d8b56a75a9e2ce158481b8320c05f7aa6a7"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.267/stella-0.9.267-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7d987e518eed0aed6f90c432f05c4e4e24f4267d276a15a5b4298cc0ccb8987e"
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
