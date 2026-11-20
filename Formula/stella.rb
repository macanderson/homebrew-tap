# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.524 / @SHA_*@ placeholders below with
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
  version "0.9.524"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.524/stella-0.9.524-aarch64-apple-darwin.tar.gz"
      sha256 "0bfdc34ad3d4616c543fe772aed9310d8236db484efc2b874b7981cdb97195b8"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.524/stella-0.9.524-x86_64-apple-darwin.tar.gz"
      sha256 "8ea9ab2c26f4661c39f100d3510dfa000c8cbd20cab645a9b99bc50b9c97eec3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.524/stella-0.9.524-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0ecb838999a178dd56d6f3f02bde8c06cdcd35d0c0c729312fdced102f0fc251"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.524/stella-0.9.524-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e34f7af2ade575963cd8cefcc939e4baec2be2297bc5e98222f8ab67ca944767"
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
