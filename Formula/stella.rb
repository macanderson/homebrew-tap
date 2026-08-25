# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.222 / @SHA_*@ placeholders below with
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
  version "0.9.222"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.222/stella-0.9.222-aarch64-apple-darwin.tar.gz"
      sha256 "0092b47efbfd6006bf3506dd50537a6392dbb311a73a099fdd28e94433c1f85d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.222/stella-0.9.222-x86_64-apple-darwin.tar.gz"
      sha256 "6e55b0c00fc376a1015b02b7edcf94992ca73091b4f93f5ef2a6e51aa949967d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.222/stella-0.9.222-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e472342078fd9435df13b44eb6d1029a738a7861fb2bd0e0b172bead1e0e967b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.222/stella-0.9.222-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8ec4581abd24724e851a3a473d901f1f119606a99fd660d21e33f3d56848fb9c"
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
