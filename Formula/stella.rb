# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.151 / @SHA_*@ placeholders below with
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
  version "0.9.151"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.151/stella-0.9.151-aarch64-apple-darwin.tar.gz"
      sha256 "6404766af7d4711107dcae7a0057d6f4542127b8529f0606946c54e3590d8f81"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.151/stella-0.9.151-x86_64-apple-darwin.tar.gz"
      sha256 "df182c1daa0b2879a3743d2afad89e3c3de7c0ead5b3483a020913e78f141ba2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.151/stella-0.9.151-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6e839805ba0d953fe97a4f50ed26e762d87f442b9a129170838d056d8a6cb5ee"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.151/stella-0.9.151-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "907da97ea739e7e3261d65c8909b45089104ac058a13d9b76968284fb981353c"
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
