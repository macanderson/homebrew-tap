# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.150 / @SHA_*@ placeholders below with
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
  version "0.9.150"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.150/stella-0.9.150-aarch64-apple-darwin.tar.gz"
      sha256 "194211ce3d90aa55c391e1c76f3b89883db6768f8c28b7c7ef73e1917a738419"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.150/stella-0.9.150-x86_64-apple-darwin.tar.gz"
      sha256 "a2cb6060fb5115dadc9d0733200cda8a7b8dbe671de9d069c18bbb323c60f3ec"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.150/stella-0.9.150-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d03d53daa10d9a9a6e0c3c06b29c3f9567b7d07d9a0db30de1ffe4b64993010e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.150/stella-0.9.150-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0c22a1056b63877b33fe15339ad36cb1014da9270b13c087673b1133aa787d72"
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
