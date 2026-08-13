# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.22 / @SHA_*@ placeholders below with
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
  version "0.9.22"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.22/stella-0.9.22-aarch64-apple-darwin.tar.gz"
      sha256 "4767d1e6e7bff1477e22ceb77eeba433bb3ef4cfaa8ecbf9c930b0ac2fcdf544"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.22/stella-0.9.22-x86_64-apple-darwin.tar.gz"
      sha256 "b338a87bae1c89e33639a3a4bc9907efd5e9957e1f5a1f2eb64691a3fd027b38"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.22/stella-0.9.22-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "28b12cc46929c5e15da98b785a885d41cef52b8c44a40b9b38e7ce93dde3ec6f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.22/stella-0.9.22-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2ba2fd81a31d7e6991afa4f1c26793ca5938b8b14cdddae41a3add8337cf29e2"
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
