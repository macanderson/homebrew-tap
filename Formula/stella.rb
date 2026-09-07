# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.394 / @SHA_*@ placeholders below with
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
  version "0.9.394"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.394/stella-0.9.394-aarch64-apple-darwin.tar.gz"
      sha256 "65b3c584c25c48b043095da3ffa62f2deeeaec75f126bb4b6a510d3e141357dd"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.394/stella-0.9.394-x86_64-apple-darwin.tar.gz"
      sha256 "47a72b200b1a8e8e7ad348f58405cd97ef9edae8ae9e4b1d4ee45fca4ccaa1a5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.394/stella-0.9.394-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0ef5042b7bcddad7e98274af3b1476f918a12bbcf68de1d583f1826503244899"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.394/stella-0.9.394-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cc209a818131e953cb802728be99fd770af7ce0045df7ec67b88828992645f2b"
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
