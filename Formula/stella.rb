# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.17 / @SHA_*@ placeholders below with
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
  version "0.5.17"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.17/stella-0.5.17-aarch64-apple-darwin.tar.gz"
      sha256 "76be456aed270cb77cc520f089aba0241e3fc48573cf001a143c63ec4c13ef0c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.17/stella-0.5.17-x86_64-apple-darwin.tar.gz"
      sha256 "0a9e23536e78e0b059c9b7a1ac99bb24bfa67ae94dbcd6823b5a5377ec975edc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.17/stella-0.5.17-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5e31388f02963b2c837814c1e0a9c407197a9fa05f061c5ffedf123dc1de1f96"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.17/stella-0.5.17-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e651af1402cc032878661ac530d15a06870794a13a8b04e47803c38058176e8e"
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
