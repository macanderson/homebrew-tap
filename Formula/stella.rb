# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.364 / @SHA_*@ placeholders below with
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
  version "0.9.364"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.364/stella-0.9.364-aarch64-apple-darwin.tar.gz"
      sha256 "d8f9f0b5f85bca56a7f600c8fba8ac9d352545895da6afa20acffc0d5933a448"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.364/stella-0.9.364-x86_64-apple-darwin.tar.gz"
      sha256 "305231478809506243a86fb1290066f777c7aa5b19729387326dc18d03769617"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.364/stella-0.9.364-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "198a97914a41d5b84aca43982dfde2da710a3fb06b37064df32da4019df3cc09"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.364/stella-0.9.364-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7da95f746addc10a336c77d439492c6b0eebea4d7bedfeb4fa5f505224b0bb93"
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
